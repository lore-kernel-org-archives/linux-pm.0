From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: Manage only online cpus
Date: Sun, 16 Dec 2012 19:07:55 +0530
Message-ID: <CAKohpomfEHGrCdbZ-EakRN4=qF8epd5seX5TWRcErQj9BEFpNA@mail.gmail.com>
References: <98330b2deb910453a356404b8cf774c94326bc42.1355636864.git.viresh.kumar@linaro.org>
	<4137114.myBUIQvsg3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <4137114.myBUIQvsg3@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linaro-dev@lists.linaro.org, nicolas.pitre@linaro.org, amit.kucheria@linaro.org, mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, pdsw-power-team@arm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16 December 2012 18:34, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday, December 16, 2012 11:20:08 AM Viresh Kumar wrote:
>> cpufreq core doesn't manage offline cpus and if driver->init() has returned
>> mask including offline cpus, it may result in unwanted behavior by cpufreq core
>> or governors.
>>
>> We need to get only online cpus in this mask. There are two places to fix this
>> mask, cpufreq core and cpufreq driver. It makes sense to do this at common place
>> and hence is done in core.
>
> Well, this series makes sense to me, but I'd like to hear what the other people
> think.

That sounds great :)

Some more information for others about how i reached to these issues
is present here:

https://lkml.org/lkml/2012/12/10/44
