From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v4 3/4] cpufreq: Add DVFS support for Armada 37xx
Date: Sun, 17 Dec 2017 19:12:16 +0100
Message-ID: <2935509.m6SLZgyEsF@aspire.rjw.lan>
References: <20171214150006.25438-1-gregory.clement@free-electrons.com> <20171214153631.GZ3322@vireshk-i7> <2201504.Sp2n0UgIp2@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2201504.Sp2n0UgIp2-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?ISO-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hua Jing <jinghua-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Neta Zur Hershkovits <neta-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Evan Wang <xswang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andre Heider <a.heider-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, December 17, 2017 7:08:53 PM CET Rafael J. Wysocki wrote:
> On Thursday, December 14, 2017 4:36:31 PM CET Viresh Kumar wrote:
> > On 14-12-17, 16:00, Gregory CLEMENT wrote:
> > > This patch adds DVFS support for the Armada 37xx SoCs
> > > 
> > > There are up to four CPU frequency loads for Armada 37xx controlled by
> > > the hardware.
> > > 
> > > This driver associates the CPU load level to a frequency, then the
> > > hardware will switch while selecting a load level.
> > > 
> > > The hardware also can associate a voltage for each level (AVS support)
> > > but it is not yet supported
> > > 
> > > Tested-by: Andre Heider <a.heider-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > ---
> > >  drivers/cpufreq/Kconfig.arm           |   7 +
> > >  drivers/cpufreq/Makefile              |   1 +
> > >  drivers/cpufreq/armada-37xx-cpufreq.c | 241 ++++++++++++++++++++++++++++++++++
> > >  3 files changed, 249 insertions(+)
> > >  create mode 100644 drivers/cpufreq/armada-37xx-cpufreq.c
> > 
> > Thanks for taking care of very minor review comments I had. All the
> > patches look good now to me :)
> 
> All applied, thanks!
> 

Actually, all except for the [4/4] as you applied it earlier.

Thanks!

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
