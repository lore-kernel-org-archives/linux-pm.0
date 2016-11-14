From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: linux-next: Tree for Nov 14 (drivers/cpufreq/intel_pstate.c)
Date: Mon, 14 Nov 2016 10:17:46 -0800
Message-ID: <1479147466.6544.21.camel@linux.intel.com>
References: <20161114182351.434e9c57@canb.auug.org.au>
         <e7f4138c-709a-b60f-e6b8-9ef4dc418d7f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e7f4138c-709a-b60f-e6b8-9ef4dc418d7f@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On Mon, 2016-11-14 at 09:48 -0800, Randy Dunlap wrote:
> On 11/13/16 23:23, Stephen Rothwell wrote:
> > 
> > Hi all,
> > 
> > Changes since 20161111:
> > 
> 
> on i386, when CONFIG_ACPI is not enabled:
> 
> ../drivers/cpufreq/intel_pstate.c: In function 'copy_cpu_funcs':
> ../drivers/cpufreq/intel_pstate.c:1798:2: error: too few arguments to
> function 'intel_pstate_use_acpi_profile'
>   intel_pstate_use_acpi_profile();
>   ^
> ../drivers/cpufreq/intel_pstate.c:1782:20: note: declared here
>  static inline void intel_pstate_use_acpi_profile(struct pstate_funcs
> *funcs)
> 
                    ^
[PATCH] cpufreq: intel_pstate: fix intel_pstate_use_acpi_profile helper
from Arnd Bergmann <arnd@arndb.de>
fixes this. 
But I am resubmitting the original patch as this is a compile issue.

Thanks,
Srinivas
