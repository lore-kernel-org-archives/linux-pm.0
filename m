From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: 37afb0003242 ("cpufreq: intel_pstate: Use ACPI perf
 configuration") makes intel_pstate kaputt
Date: Tue, 17 Nov 2015 09:06:30 -0800
Message-ID: <1447779990.2778.47.camel@spandruv-desk3.jf.intel.com>
References: <20151117090947.GC8819@pd.tnic>
	 <7244050.99ueqT3SFL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7244050.99ueqT3SFL@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@alien8.de>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2015-11-17 at 15:38 +0100, Rafael J. Wysocki wrote:
> On Tuesday, November 17, 2015 10:09:47 AM Borislav Petkov wrote:
> > Hi,
> > 

[...]
> > during boot.

Also can you try with processor.ignore_ppc=1 in kernel command line.

Thanks,
Srinivas
> > 
> > When I boot with "intel_pstate=no_acpi" it boosts normally to 3.4GHz and
> > above and turbostat says:
> > 
> >      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
> >        -    3392   99.92    3400    2895
> >        0    3395   99.96    3400    2897
> >        1    3390   99.88    3400    2895
> >        2    3391   99.89    3400    2895
> >        3    3391   99.95    3400    2893
> > 
> > which is what it should be saying. :)
> 
> Well, sorry for the breakage.
> 
> acpidump output would help to diagnose this I suppose.
> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
