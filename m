From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] Cpufreq: Make governor data on nonboot cpus across
 system suspend/resume
Date: Thu, 21 Nov 2013 21:24:02 +0530
Message-ID: <CAKohponphVhZ3T1HD2AfhPBUn9SfQyrqdbvW3bEJFzRdKF2i0Q@mail.gmail.com>
References: <9847309.KdKOG5y1Zx@vostro.rjw.lan>
	<1384616184-6197-1-git-send-email-tianyu.lan@intel.com>
	<2383693.rhJDd9X40m@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2383693.rhJDd9X40m@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lan Tianyu <tianyu.lan@intel.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21 November 2013 20:13, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> -     if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
>
> The inner parens are not necessary.
>
>> -                     ((event == CPUFREQ_GOV_POLICY_EXIT) && !ret))
>> +     if ((event == CPUFREQ_GOV_POLICY_INIT) && ret) {
>
> Same here.
>
>> +             module_put(policy->governor->owner);
>> +             if (ret == -EALREADY)
>> +                     return 0;
>> +     } else if ((event == CPUFREQ_GOV_POLICY_EXIT) && !ret) {
>
> Same here.

Logically, yes you are correct. But probably its better for readability to
get these even if you know precedence is going to take care of our
expression..
