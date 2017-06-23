From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] ACPI / sleep: EC-based wakeup from suspend-to-idle
 on recent systems
Date: Fri, 23 Jun 2017 09:06:28 -0700
Message-ID: <1498233988.7952.45.camel@linux.intel.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
         <2026371.DVJN39QYJi@aspire.rjw.lan> <2368998.dmCsnrcXZy@aspire.rjw.lan>
         <2279758.LZ0rCGQtcH@aspire.rjw.lan>
         <3f1cbd8cd7e54576b17c788f4eae2205@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3f1cbd8cd7e54576b17c788f4eae2205@ausx13mpc120.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org, andriy.shevchenko@linux.intel.com, dvhart@infradead.org, linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, tom@oneshoeco.com, jerome.debretagne@gmail.com, torvalds@linux-foundation.org, lv.zheng@intel.com
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-06-23 at 15:37 +0000, Mario.Limonciello@dell.com wrote:

[...]

> > 
> > +#define ACPI_LPS0_SCREEN_ON	4
> > +#define ACPI_LPS0_ENTRY		5
> > +#define ACPI_LPS0_EXIT		6
> The spec you shared also defines device constraints (function 1). It
> would be very 
> useful if these constraints  could be parsed and compared against the
> actual power 
> states of devices on the system at least for debugging purposes.  I'm
> not sure if you 
> already had a plan for that in a future series.
> 
For debug purpose, I have worked on a patch to dump the constraint
table in debugfs. But in the freeze path whether we meet the
constraints or not will not make any difference, other than for just
debugging.

Thanks,
Srinivas
