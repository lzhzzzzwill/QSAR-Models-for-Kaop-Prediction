library(ggplot2)      
library(RColorBrewer)  
library(ggpubr)
library(pheatmap)
library(cowplot)
library(ggplotify)
library(ggplot2)
library(dplyr)
library(ggpmisc)
library(patchwork)


getwd()

#Fig.2a. Internal and external validation results
h12 <- read.csv("OH1.csv",header = T,row.names = 1)
h22 <- read.csv("OH2.csv",header = T,row.names = 1)

hp12 <- pheatmap(h12, cluster_rows = F, cluster_cols = F,
                 col = brewer.pal(9,"YlGnBu")[1:7],
                 angle_col = 0)
hp12
hp22 <- pheatmap(h22, cluster_rows = F, cluster_cols = F,
                 col = brewer.pal(9,"YlGnBu")[3:9],
                 angle_col = 0)
hp22

g12 = as.ggplot(hp12)
g22 = as.ggplot(hp22)

OH <- plot_grid(g12, g22, ncol=1)
OH 

ggsave(filename = 'fig2a.pdf', width = 12, height = 6)

#Fig.2b. Applicability domain characterisation
h21 <- read.csv("OH3.csv",header = T,row.names = 1)
h22 <- read.csv("OH4.csv",header = T,row.names = 1)
h23 <- read.csv("OH5.csv",header = T,row.names = 1)
h24 <- read.csv("OH6.csv",header = T,row.names = 1)

hp21 <- pheatmap(h21, cluster_rows = F, cluster_cols = F,
                 annotation_row = h22,
                 col = brewer.pal(9,"YlGnBu")[1:7],
                 angle_col = 315)
hp21
hp22 <- pheatmap(h23, cluster_rows = F, cluster_cols = F,
                 annotation_row = h24,
                 col = brewer.pal(9,"YlGnBu")[3:9],
                 angle_col = 315)
hp22

g21 = as.ggplot(hp21)
g22 = as.ggplot(hp22)

OH <- plot_grid(g21, g22, ncol=1)
OH 
ggsave(filename = 'fig2b.pdf', width = 12, height = 6)

#Fig.5. Practical application of k·OH.
OH <- read.csv("OH7.csv",sep=",",na.strings="NA",stringsAsFactors=FALSE)

OH$Organic.contaminants <- factor(OH$Organic.contaminants, 
                                  levels=c("Tylosin", "Tetracycline",
                                           "Trimethoprim", "Sulfathiazole",
                                           "Roxithromycin ", "Enrofloxacin",
                                           "Ciprofloxacin", "Sulfadimethoxine",
                                           "Lomefloxacin","Norfloxacin",
                                           "Sulfamethoxazole", "Sulfamerazine",
                                           "Sulfamethazine", "Ofloxacin",
                                           "Azithromycin"), 
                                  ordered=TRUE)

OH1 <- ggplot(OH,aes(Organic.contaminants,lgkOH,
                     fill= Group, 
                     color="black"))+
  geom_bar(stat="identity",
           position="dodge",
           color="black", width=0.7,size=0.25) +
  scale_fill_brewer(palette="YlGnBu")+
  xlab("Organic.contaminants") + 
  scale_y_continuous(limits = c(0, 10)) +
  theme_bw() + 
  theme(axis.text.x=element_text(size=45),
        axis.text.y=element_text(size=45),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=25), 
        legend.text = element_text(size=25),
        legend.position = "none", #none
        panel.border = element_rect(linetype=1,size=5.5)) +
  ylab(expression(lgk)) +
  guides(fill=guide_legend(title="Class", nrow = 1)) 

OH1
OH2 <- OH1+theme(axis.text.x = element_text(angle = 90, hjust = 1))
OH3 <- OH2 + stat_compare_means(aes(label =..p.signif..), 
                                method = "wilcox.test", 
                                method.args = list(alternative = "two.sided")) 
OH3
ggsave(filename = 'fig5.pdf', width = 12.5, height =14)

#Fig.S1 The distribution of experimental lgk·OH in the data sets. (SVM as example)
OH <- read.csv("OH8.csv",sep=",",na.strings="NA",
               stringsAsFactors=FALSE)
OH$class <- factor(OH$class, levels=c('Training set', 'Test set'))
OH1<-ggplot(OH,aes(x=lgkOH, fill = class))+
  geom_histogram(binwidth= 1, alpha = 0.55, color = "black", size = 0.25) +
  theme_bw()+
  scale_fill_brewer(palette= "YlGnBu")+ 
  theme(axis.text.x=element_text(size=30),
        axis.text.y=element_text(size=30),
        axis.title.x =element_text(size=35), 
        axis.title.y=element_text(size=35),
        legend.title = element_text(size=25), 
        legend.text = element_text(size=25),
        legend.position = "top", #none
        panel.border = element_rect(linetype=1,size=3.5)) +
  ylab(expression(Count)) + xlab(expression(lgk)) +
  guides(fill=guide_legend(title="Class", nrow = 1)) 
OH1
ggsave(filename = 'figs1.pdf', width = 6, height = 4)

#Fig.S5 Comparison of predicted versus experimental values for k·OH.
brewer.pal(n = 8, name = "YlGnBu")

#ap
ap <- read.csv ("ap.csv",stringsAsFactors=FALSE)  
ap <- ggplot(ap, aes(x=Experimental.value, y=Predictive.value,
                     colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
ap
ggsave(filename = 'ap.pdf', width = 9, height = 8)
#apc
apc <- read.csv ("apc.csv",stringsAsFactors=FALSE)  
apc <- ggplot(apc, aes(x=Experimental.value, y=Predictive.value,
                       colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
apc
ggsave(filename = 'apc.pdf', width = 9, height = 8)
#cdk
cdk <- read.csv ("cdk.csv",stringsAsFactors=FALSE)  
cdk <- ggplot(cdk, aes(x=Experimental.value, y=Predictive.value,
                       colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
cdk
ggsave(filename = 'cdk.pdf', width = 9, height = 8)
#estate
estate <- read.csv ("estate.csv",stringsAsFactors=FALSE)  
estate <- ggplot(estate, aes(x=Experimental.value, y=Predictive.value,
                             colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
estate
ggsave(filename = 'estate.pdf', width = 9, height = 8)
#ext
ext <- read.csv ("ext.csv",stringsAsFactors=FALSE)  
ext <- ggplot(ext, aes(x=Experimental.value, y=Predictive.value,
                       colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
ext
ggsave(filename = 'ext.pdf', width = 9, height = 8)
#graph
graph<- read.csv ("graph.csv",stringsAsFactors=FALSE)  
graph <- ggplot(graph, aes(x=Experimental.value, y=Predictive.value,
                           colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
graph
ggsave(filename = 'graph.pdf', width = 9, height = 8)
#kr
kr<- read.csv ("kr.csv",stringsAsFactors=FALSE)  
kr <- ggplot(kr, aes(x=Experimental.value, y=Predictive.value,
                     colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
kr
ggsave(filename = 'kr.pdf', width = 9, height = 8)
#krc
krc<- read.csv ("krc.csv",stringsAsFactors=FALSE)  
krc <- ggplot(krc, aes(x=Experimental.value, y=Predictive.value,
                       colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
krc
ggsave(filename = 'krc.pdf', width = 9, height = 8)
#maccs
maccs<- read.csv ("maccs.csv",stringsAsFactors=FALSE)  
maccs<- ggplot(maccs, aes(x=Experimental.value, y=Predictive.value,
                          colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
maccs
ggsave(filename = 'maccs.pdf', width = 9, height = 8)
#morgan
morgan<- read.csv ("morgan.csv",stringsAsFactors=FALSE)  
morgan<- ggplot(morgan, aes(x=Experimental.value, y=Predictive.value,
                            colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
morgan
ggsave(filename = 'morgan.pdf', width = 9, height = 8)
#pub
pub<- read.csv ("pub.csv",stringsAsFactors=FALSE)  
pub<- ggplot(pub, aes(x=Experimental.value, y=Predictive.value,
                      colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
pub
ggsave(filename = 'pub.pdf', width = 9, height = 8)
#sub
sub <- read.csv ("sub.csv",stringsAsFactors=FALSE)  
sub <- ggplot(sub, aes(x=Experimental.value, y=Predictive.value,
                       colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
sub
ggsave(filename = 'sub.pdf', width = 9, height = 8)
#subc
subc <- read.csv ("subc.csv",stringsAsFactors=FALSE)  
subc <- ggplot(subc, aes(x=Experimental.value, y=Predictive.value,
                         colour = Class)) +  
  geom_point(alpha=0.7,size=4) + 
  scale_colour_manual(values=c("#7FCDBB","#225EA8"))+
  theme_bw() + 
  scale_x_continuous(limits = c(6, 11)) +
  scale_y_continuous(limits = c(6, 11)) +
  theme(plot.margin=unit(rep(2,5),'lines')) +
  theme(legend.position = "bottom") +
  geom_abline(alpha=0.8, intercept = 0, slope = 1, size=2) +
  theme(axis.text.x=element_text(size=40),
        axis.text.y=element_text(size=40),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=50), 
        legend.text = element_text(size=40),
        panel.border = element_rect(linetype=1,size=2.5)) 
subc
ggsave(filename = 'subc.pdf', width = 9, height = 8)

#Fig.S7 The top-twenty ranks of the QSAR models for k·OH.
zhudata <- read.csv("OH9.csv",sep=",",na.strings="NA",
                     stringsAsFactors=FALSE)

z <- ggplot(zhudata,aes(x = reorder(QSAR.model, Q2),
                          y = Q2,
                          fill = GROUP))+
  geom_bar(stat="identity",
           #position="stack", "dodge"
           position="dodge",
           color="black", width=0.7,size=0.25) +
  #Changing color
  scale_fill_brewer(palette="YlGnBu")+
  xlab("QSAR.model") + ylab(expression(Q[ext]^2)) + 
  #Transpose
  coord_flip()+ 
  theme_bw()
z
ggsave(filename = 'figs7.pdf', width = 12, height = 6)

#Fig.S8 Comprehensive performance of machine learning models for k·OH.
OH <- read.csv("OH10.csv",header = T,row.names = 1)
OH$Model <- as.factor(OH$Model)
V2 <- ggplot(OH, aes(x = Model, y = R2))+
  geom_violin(aes(fill = Model), trim = FALSE) +
  geom_boxplot(width = 0.2) + scale_fill_brewer(palette="YlGnBu") +
  theme_bw() +
  theme(axis.text.x=element_text(size=30),
        axis.text.y=element_text(size=30),
        axis.title.x =element_text(size=35), 
        axis.title.y=element_text(size=35),
        legend.title = element_text(size=35), 
        legend.text = element_text(size=25),
        legend.position = "none", #none
        panel.border = element_rect(linetype=1,size=3.5)) +
  ylab(expression(R^2)) + xlab(expression(Model)) +
  guides(fill=guide_legend(title="Class", nrow = 1))
V2
ggsave(filename = 'figs8.pdf', width = 8, height = 8)

#Fig.S9. The average similarities of the models for the practical application
OH11 <- read.csv("OH11.csv",sep=",",na.strings="NA",stringsAsFactors=FALSE)

OH11$Organic.contaminants <- factor(OH11$Organic.contaminants, 
                                    levels=c("RF-Pub",
                                             "Tylosin", "Tetracycline",
                                             "Trimethoprim", "Sulfathiazole",
                                             "Roxithromycin ", "Enrofloxacin",
                                             "Ciprofloxacin", "Sulfadimethoxine",
                                             "Lomefloxacin","Norfloxacin",
                                             "Sulfamethoxazole", "Sulfamerazine",
                                             "Sulfamethazine", "Ofloxacin",
                                             "Azithromycin"), 
                                    ordered=TRUE)

oh <- ggplot(OH11,aes(Organic.contaminants,Average.similarity,fill= Group,
                      color="black"))+
  geom_bar(stat="identity",
           position="dodge",
           color="black", width=0.7,size=0.25) +
  scale_fill_brewer(palette="YlGnBu")+
  xlab("Organic.contaminants") +
  theme_bw() +
  theme(axis.text.x=element_text(size=45),
        axis.text.y=element_text(size=45),
        axis.title.x =element_text(size=50), 
        axis.title.y=element_text(size=50),
        legend.title = element_text(size=25), 
        legend.text = element_text(size=25),
        legend.position = "none", #none
        panel.border = element_rect(linetype=1,size=5.5)) +
  ylab(expression(Average.similarity)) +
  guides(fill=guide_legend(title="Class", nrow = 1)) 

oh1 <- oh+theme(axis.text.x = element_text(angle = 90, hjust = 1))
oh1
ggsave(filename = 'figs9.pdf', width = 12.5, height =14)