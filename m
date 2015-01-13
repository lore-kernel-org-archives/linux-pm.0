From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 06/17] thermal: cpu_cooling: dts: Define device tree
 bindings for Exynos cpu cooling functionality
Date: Tue, 13 Jan 2015 09:22:21 +0100
Message-ID: <20150113092221.1326b147@amdc2363>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-7-git-send-email-l.majewski@samsung.com>
 <20150102181529.GC12130@developer> <20150112150916.43f5b7ff@amdc2363>
 <20150112142417.GA28377@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20150112142417.GA28377@developer>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> 
> On Mon, Jan 12, 2015 at 03:09:16PM +0100, Lukasz Majewski wrote:
> > Hi Eduardo,
> > 
> > > > Presented patch aims to move data necessary for correct CPU
> > > > cooling device configuration from exynos_tmu_data.c to device
> > > > tree.  
> > > 
> > > I believe the patch title is misleading. Looks like you are
> > > changing something at cpu cooling, but in fact, you are changing
> > > DTS files. I would suggest you to use a prefix like 'arm:
> > > dts: ....'
> > 
> > Now this patch name is:
> > thermal: cpu_cooling: dts: ......
> > 
> > All the code in this patch adds bindings for 'thermal-zone' to map
> > cooling device to proper trip points.
> > In fact this is solely related to cpu_cooling...
> > 
> > From the above, I think that the already provided convention is more
> > suitable and "arm: dts: cpu_cooling: thermal" seems a bit awkward
> > for me.
> > 
> > If you don't regard my justification as valid, then I will fix this.
> 
> Still, the naming is confusing. With that prefix you are saying this
> patch is something generic about cpu cooling and thermal dts. And that
> is not what this patch is about.
> 
> Saying "arm: dts: add cpu cooling bindings for Exynos" is a short and
> direct subject. Besides, you have the plus to call the attention of
> the ARM and device tree maintainers. It will be also in my radar.

Fair enough. Thanks for clarification.

> 
> 
> The original subject also makes me think you are dealing with C code,
> while the former says already upfront that you are talking about arm
> dts bindings. 
> 
> Cheers,
> > 
> > -- 
> > Best regards,
> > 
> > Lukasz Majewski
> > 
> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
