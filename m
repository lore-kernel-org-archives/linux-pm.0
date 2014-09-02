From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap/rapl: lower warning level for domain detection
Date: Tue, 2 Sep 2014 10:57:18 -0700
Message-ID: <20140902105718.7e9ec107@ultegra>
References: <1409288168-6537-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<2181254.mWuCKKqmQW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2181254.mWuCKKqmQW@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 02 Sep 2014 01:48:40 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Thursday, August 28, 2014 09:56:08 PM Jacob Pan wrote:
> > Many CPUs do not support complete set of RAPL domains, as a
> > result this detection failed message is very misleading and
> > annoying. So loweab Pan <jacob.jun.pan@linux.intel.com>
> 
> What about printing a (info-level) message if the RAPL domain *is*
> supported?  That surely is more interesting?
> 
yes, that is better. just sent out an updated patch with a different
Subject: [PATCH] powercap/rapl: change domain detection message

Thanks,

Jacob
> > ---
> >  drivers/powercap/intel_rapl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c
> > b/drivers/powercap/intel_rapl.c index b1cda6f..0b282e7 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -1169,7 +1169,7 @@ static int rapl_detect_domains(struct
> > rapl_package *rp, int cpu) if (!rapl_check_domain(cpu, i))
> >  			rp->domain_map |= 1 << i;
> >  		else
> > -			pr_warn("RAPL domain %s detection
> > failed\n",
> > +			pr_info("RAPL domain %s not supported\n",
> >  				rapl_domain_names[i]);
> >  	}
> >  	rp->nr_domains = bitmap_weight(&rp->domain_map,
> > RAPL_DOMAIN_MAX);
> > 
> 

[Jacob Pan]
