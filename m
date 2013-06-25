From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] CPUFreq: Add new sysfs attribute freqdomain_cpus for acpi-freq driver
Date: Wed, 26 Jun 2013 01:03:42 +0200
Message-ID: <4163057.9R6dzfOLVQ@vostro.rjw.lan>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com> <51C95282.3040305@intel.com> <CAKohpokU8MEFk8RsAmdraeX-SJPTFYwjkVSFFMMSGbUNmOm=Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokU8MEFk8RsAmdraeX-SJPTFYwjkVSFFMMSGbUNmOm=Vg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 25, 2013 09:01:03 PM Viresh Kumar wrote:
> On 25 June 2013 13:49, Lan Tianyu <tianyu.lan@intel.com> wrote:
> > Ok. From my opinion, the new attribute is an ABI and it's better to add
> > descriptor under Document directory. The user can be easy to find how to
> > use it.
> 
> Hmm.. So maybe acpi-cpufreq file would be a good starting point. Then
> it can have more details about the driver in future.
> 
> > Please see the commit which add the code. Maybe, we should overwrite
> > shared_cpu_map by sibling_cpus for this case?
> 
> Not sure if changing shared_cpu_map has any other implications or not.

Well, I wouldn't change it, then.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
