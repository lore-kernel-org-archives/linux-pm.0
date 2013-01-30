From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
Date: Wed, 30 Jan 2013 14:57:48 +0100
Message-ID: <1620717.9QAjdjU4WH@vostro.rjw.lan>
References: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org> <2871120.foIQeGmlHR@vostro.rjw.lan> <20130130134939.GE2757@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130130134939.GE2757@S2101-09.ap.freescale.net>
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Langsdorf <mark.langsdorf@calxeda.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 30, 2013 09:49:41 PM Shawn Guo wrote:
> On Wed, Jan 30, 2013 at 02:40:35PM +0100, Rafael J. Wysocki wrote:
> > > > Mark, AnilKumar,
> > > > 
> > > > I only compile-tested it on highbank and omap2.  Please give it a test
> > > > no hardware to make sure cpufreq-cpu0 still works for you.  Thanks.
> > > 
> > > Hi Shawn,
> > > 
> > > I hope this is based on linux-omap/master, to test the driver I have
> > > to add some patches on top of this patch, because of recent changes.
> > > I will provide the test details once I am done.
> > 
> > Shawn, does it mean I need to wait with applying the patch or will OMAP2
> > work as is?
> > 
> I would expect that omap2/am33xx should work as it is, but I do not
> have hardware to confirm that.
> 
> Also as the patch touches a few files in arch/arm/mach-omap2, we may
> need an ACK from Tony.
> 
> Actually, I prefer to move omap2 bits into a separate patch and have
> it go via omap tree to avoid the possible conflict with cpufreq and
> arm-soc tree.  What do you say?  If you agree, I will re-iterate the
> patch to do so.

Yes, please do as you think is appropriate.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
