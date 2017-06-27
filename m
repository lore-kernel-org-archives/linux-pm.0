From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap/rapl: prevent overridding bits outside of the
 mask
Date: Tue, 27 Jun 2017 09:25:56 -0700
Message-ID: <20170627092556.082a58c7@jacob-builder>
References: <20170601092150.4474-1-adam.lessnau@intel.com>
        <30611930.SfmUctH6tv@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:39868 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752530AbdF0QYS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Jun 2017 12:24:18 -0400
In-Reply-To: <30611930.SfmUctH6tv@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Adam Lessnau <adam.lessnau@intel.com>, linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com

On Tue, 27 Jun 2017 02:17:32 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Thursday, June 01, 2017 11:21:50 AM Adam Lessnau wrote:
> > Fixes wrong bits shift operation in the rapl_write_data_raw
> > function, which might cause overridding bits outside of the mask.
> > 
> > For example, writing new TIME_WINDOW1 value can override
> > POWER_LIMIT1.
> > 
> > Signed-off-by: Adam Lessnau <adam.lessnau@intel.com>  
> 
> Jacob, any comments?
> 
Looks like a good fix. Thanks.
> > ---
> >  drivers/powercap/intel_rapl.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c
> > b/drivers/powercap/intel_rapl.c index 3c71f608b444..6dc27afb8527
> > 100644 --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -887,7 +887,9 @@ static int rapl_write_data_raw(struct
> > rapl_domain *rd, 
> >  	cpu = rd->rp->lead_cpu;
> >  	bits = rapl_unit_xlate(rd, rp->unit, value, 1);
> > -	bits |= bits << rp->shift;
> > +	bits <<= rp->shift;
> > +	bits &= rp->mask;
> > +
> >  	memset(&ma, 0, sizeof(ma));
> >  
> >  	ma.msr_no = rd->msrs[rp->id];
> >   
> 

[Jacob Pan]
