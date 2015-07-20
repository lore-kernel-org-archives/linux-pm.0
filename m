From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] ACPI / cpufreq: ACPI processor driver and ACPI cpufreq driver cleanups
Date: Tue, 21 Jul 2015 00:40:06 +0200
Message-ID: <3632030.c4a7aMnN04@vostro.rjw.lan>
References: <10273534.kyzK8rhvUz@vostro.rjw.lan> <20150718060446.GB11802@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150718060446.GB11802@linux>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pan Xinhui <xinhuix.pan@intel.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, July 18, 2015 11:34:46 AM Viresh Kumar wrote:
> On 18-07-15, 03:13, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The following two patches clean up a couple of things in the ACPI processor
> > driver and the ACPI cpufreq driver:
> > 
> > [1/2] Drop the unused first argument of acpi_processor_unregister_performance().
> > [2/2] Drop the now redundant acpi_data pointer from acpi_cpufreq_data.
> > 
> > Both patches on top of the current linux-next branch of the linux-pm.git tree.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, but I've just sent new versions out.

Rafael

