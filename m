From: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Subject: Re: [PATCH 1/4] powercap / RAPL: Add support for Skylake H/S
Date: Fri, 31 Jul 2015 16:48:38 -0700
Message-ID: <20150731164838.3ce77735@radivoje-desk2>
References: <1438355230-124417-1-git-send-email-radivoje.jovanovic@linux.intel.com>
	<2146189.SigK4bD24C@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55872 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbbGaXvU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 31 Jul 2015 19:51:20 -0400
In-Reply-To: <2146189.SigK4bD24C@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jacob Pan Jun <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>

On Sat, 01 Aug 2015 02:12:18 +0200
Hi Rafael,

"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> On Friday, July 31, 2015 08:07:10 AM Radivoje Jovanovic wrote:
> > From: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
> > 
> > This patche enabled RAPL to support Intel Skylake H/S
> > 
> > Signed-off-by: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
> 
> Jacob, is this series fine by you?

Jacob is on sabbatical and asked me to sub him for RAPL/Powercap until
he comes back

> 
> > ---
> >  drivers/powercap/intel_rapl.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c
> > b/drivers/powercap/intel_rapl.c index 482b22d..bca9620 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -1101,6 +1101,7 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst = { RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
> >  	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
> >  	RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
> > +	RAPL_CPU(0x5E, rapl_defaults_core),/* Skylake-H/S */
> >  	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights
> > Landing */ {}
> >  };
> > 
> 

