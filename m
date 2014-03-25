From: Vinson Lee <vlee@twopensource.com>
Subject: Re: [stable request <=3.7] acpi-cpufreq: set current frequency based
 on target P-State
Date: Tue, 25 Mar 2014 15:53:40 -0700
Message-ID: <CAHTgTXVEjNUMkrTNSyu+TtXc+Ac5PsD8Sp4m-7Md6UNwQfwkJQ@mail.gmail.com>
References: <20131220081912.GA13684@hobo.Home>
	<1395785057-28903-1-git-send-email-vlee@twopensource.com>
	<20140325221803.GA32518@hobo.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20140325221803.GA32518@hobo.lan>
Sender: cpufreq-owner@vger.kernel.org
To: Ross Lagerwall <rosslagerwall@gmail.com>
Cc: stable@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shatil Rafiullah <srafiullah@twopensource.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 25, 2014 at 3:18 PM,  <rosslagerwall@gmail.com> wrote:
> On Tue, Mar 25, 2014 at 03:04:16PM -0700, Vinson Lee wrote:
>> Hi.
>>
>> Please backport upstream commit 8673b83bf2f013379453b4779047bf3c6ae387e4
>> "acpi-cpufreq: set current frequency based on target P-State" to stable
>> kernels 3.7 and earlier. This patch enables the kernel to control
>> P-states on several platforms. Without this patch, the kernel was unable
>> to control P-states on the same platforms.
>>
>> The upstream patch cleanly applies to 3.7.
>>
>> A backported patch is needed with the removal of SYSTEM_AMD_MSR_CAPABLE
>> for kernels 3.6 and earlier.
>>
>
> I seem to recall that the problem was a regression introduced by commit
> 5a1c0228 (cpufreq: Avoid calling cpufreq driver's target() routine if
> target_freq == policy->cur) which was introduced in the 3.8 cycle.  Are
> you sure it is necessary for kernels < 3.8?
>
> Regards
> --
> Ross Lagerwall


This specific patch allows P-states to work with the 3.4 kernel on
several hardware platforms.

Perhaps this is not the correct patch to backport. However, P-states
are not working properly with the 3.4 kernel, even though it does not
have the regression commit 5a1c0228 "cpufreq: Avoid calling cpufreq
driver's target() routine if target_freq == policy->cur" backported.

Cheers,
Vinson
