From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 2/2 V7] intel_pstate: add kernel parameter to force
 loading on Sun X86 servers.
Date: Thu, 4 Dec 2014 14:38:53 -0800
Message-ID: <20141204143853.1adf98d8@kcaccard-desk.amr.corp.intel.com>
References: <1417658851-8729-1-git-send-email-ethan.zhao@oracle.com>
	<22893638.NKVNYzPHrg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <22893638.NKVNYzPHrg@vostro.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ethan Zhao <ethan.zhao@oracle.com>, dirk.j.brandewie@intel.com, linda.knippers@hp.com, viresh.kumar@linaro.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, ethan.kernel@gmail.com
List-Id: linux-pm@vger.kernel.org

On Thu, 04 Dec 2014 23:10:58 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Thursday, December 04, 2014 11:07:31 AM Ethan Zhao wrote:
> > To force loading on Oracle Sun X86 servers, provide one kernel command line
> > parameter
> > 
> >   intel_pstate = ora_force
> 
> I would suggest to change the name of the option to "oracle_force" or "sun_force"
> for clarity.
> 
> Anyway, I need an ACK from Kristen if this patch is to be applied.
> 
> > For those who be aware of the risk of no power capping capabily working and
> > try to get better performance with this driver.
> > 
> > Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
> > ---
> >  v2: change to hardware vendor specific naming parameter.
> >  v4: refine code and doc.
> >  v5&v6: fix a typo in doc.
> >  v7: change enum PCC to PPC.
> > 
> >  Documentation/kernel-parameters.txt | 5 +++++
> >  drivers/cpufreq/intel_pstate.c      | 6 +++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> > index 479f332..7d0983e 100644
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -1446,6 +1446,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> >  		       disable
> >  		         Do not enable intel_pstate as the default
> >  		         scaling driver for the supported processors
> > +		       ora_force
> > +			 Force loading intel_pstate on Oracle Sun Servers(X86).
> > +			 only for those who be aware of the risk of no power capping
> > +			 capability working and try to get better performance with this
> > +			 driver.
> 
> That is not sufficiently clear.  What does "risk of no power capping capability
> working" mean, in particular?
> 
> >  
> >  	intremap=	[X86-64, Intel-IOMMU]
> >  			on	enable Interrupt Remapping (default)
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 1bb62ca..2654e13 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -866,6 +866,7 @@ static struct cpufreq_driver intel_pstate_driver = {
> >  };
> >  
> >  static int __initdata no_load;
> > +static unsigned int  ora_force;
> >  
> >  static int intel_pstate_msrs_not_valid(void)
> >  {
> > @@ -1003,7 +1004,8 @@ static bool intel_pstate_platform_pwr_mgmt_exists(void)
> >  			case PSS:
> >  				return intel_pstate_no_acpi_pss();
> >  			case PPC:
> > -				return intel_pstate_has_acpi_ppc();
> > +				return intel_pstate_has_acpi_ppc() &&
> > +					(!ora_force);
> >  			}
> >  	}
> >  
> > @@ -1078,6 +1080,8 @@ static int __init intel_pstate_setup(char *str)
> >  
> >  	if (!strcmp(str, "disable"))
> >  		no_load = 1;
> > +	if (!strcmp(str, "ora_force"))
> > +		ora_force = 1;
> >  	return 0;
> >  }
> >  early_param("intel_pstate", intel_pstate_setup);
> 
> And can anyone please remind me what was wrong with a "force" option that would
> work for everyone, not just Oracle/Sun?
> 

That was my suggestion as well (i.e. a parameter to bypass the vendor
checks), but Linda didn't like it.  My personal opinion is that unless
it's generic, I don't really feel like having a force option solely for
oracle.  I'm not convinced you want this for production machines, and I
think for debug purposes I don't want a vendor specific param.

