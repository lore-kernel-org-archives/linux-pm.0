From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] powercap / RAPL: Add support for Skylake H/S
Date: Sat, 01 Aug 2015 02:29:41 +0200
Message-ID: <4137480.UuHOruFrol@vostro.rjw.lan>
References: <1438355230-124417-1-git-send-email-radivoje.jovanovic@linux.intel.com> <2146189.SigK4bD24C@vostro.rjw.lan> <20150731164838.3ce77735@radivoje-desk2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57065 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932156AbbHAACn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 20:02:43 -0400
In-Reply-To: <20150731164838.3ce77735@radivoje-desk2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Cc: Jacob Pan Jun <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>

On Friday, July 31, 2015 04:48:38 PM Radivoje Jovanovic wrote:
> On Sat, 01 Aug 2015 02:12:18 +0200
> Hi Rafael,
> 
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > On Friday, July 31, 2015 08:07:10 AM Radivoje Jovanovic wrote:
> > > From: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
> > > 
> > > This patche enabled RAPL to support Intel Skylake H/S
> > > 
> > > Signed-off-by: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
> > 
> > Jacob, is this series fine by you?
> 
> Jacob is on sabbatical and asked me to sub him for RAPL/Powercap until
> he comes back

OK

I can apply [1-2/4], then, the rest I'm leaving to Rui.


> > 
> > > ---
> > >  drivers/powercap/intel_rapl.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/powercap/intel_rapl.c
> > > b/drivers/powercap/intel_rapl.c index 482b22d..bca9620 100644
> > > --- a/drivers/powercap/intel_rapl.c
> > > +++ b/drivers/powercap/intel_rapl.c
> > > @@ -1101,6 +1101,7 @@ static const struct x86_cpu_id rapl_ids[]
> > > __initconst = { RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
> > >  	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
> > >  	RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
> > > +	RAPL_CPU(0x5E, rapl_defaults_core),/* Skylake-H/S */
> > >  	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights
> > > Landing */ {}
> > >  };
> > > 
> > 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
