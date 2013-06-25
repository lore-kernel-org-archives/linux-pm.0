From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] CPUFreq: Add new sysfs attribute freqdomain_cpus for
 acpi-freq driver
Date: Tue, 25 Jun 2013 21:01:03 +0530
Message-ID: <CAKohpokU8MEFk8RsAmdraeX-SJPTFYwjkVSFFMMSGbUNmOm=Vg@mail.gmail.com>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com>
	<1372126006-4950-2-git-send-email-tianyu.lan@intel.com>
	<CAKohpokUmvkkGwCDDa1d8OCz8YcsE2J0GQkA-dJ=EE+6REm7Mg@mail.gmail.com>
	<51C93E9E.3030107@intel.com>
	<CAKohpo=K8fN=AhSKRRNRq-UXNhJ3YFVe6YKG+mAbq079TD4Yyg@mail.gmail.com>
	<51C95282.3040305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51C95282.3040305@intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@sisk.pl, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 25 June 2013 13:49, Lan Tianyu <tianyu.lan@intel.com> wrote:
> Ok. From my opinion, the new attribute is an ABI and it's better to add
> descriptor under Document directory. The user can be easy to find how to
> use it.

Hmm.. So maybe acpi-cpufreq file would be a good starting point. Then
it can have more details about the driver in future.

> Please see the commit which add the code. Maybe, we should overwrite
> shared_cpu_map by sibling_cpus for this case?

Not sure if changing shared_cpu_map has any other implications or not.
