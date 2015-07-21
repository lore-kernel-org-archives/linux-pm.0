From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/3] ACPI / cpufreq: ACPI processor driver and ACPI
 cpufreq driver cleanups
Date: Tue, 21 Jul 2015 08:03:30 +0530
Message-ID: <20150721023330.GE4994@linux>
References: <10273534.kyzK8rhvUz@vostro.rjw.lan>
 <1504169.B7TvYS4CS0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504169.B7TvYS4CS0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pan Xinhui <xinhuix.pan@intel.com>
List-Id: linux-pm@vger.kernel.org

On 21-07-15, 00:12, Rafael J. Wysocki wrote:
> On Saturday, July 18, 2015 03:13:41 AM Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The following two patches clean up a couple of things in the ACPI processor
> > driver and the ACPI cpufreq driver:
> > 
> > [1/2] Drop the unused first argument of acpi_processor_unregister_performance().
> > [2/2] Drop the now redundant acpi_data pointer from acpi_cpufreq_data.
> 
> New versios of the two above (as [2/3] and [3/3], respectively) plus one
> more ACPI cpufreq driver cleanup (discussed on linux-pm previously).

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
