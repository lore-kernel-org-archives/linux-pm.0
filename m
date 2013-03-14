From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 4/4] cpufreq: Add Kconfig option to enable/disable have_multiple_policies
Date: Thu, 14 Mar 2013 08:39:55 +0530
Message-ID: <CAKohpokwdtSwQmcK=gb2mpzjzp0vpbS7Sra-EhM3QsiQwpog1w@mail.gmail.com>
References: <cover.1362381470.git.viresh.kumar@linaro.org>
	<1687194.MelaMkNoiM@vostro.rjw.lan>
	<CAKohpompsA5bR6TauM7Wa6ciLxYYc7GdpN1NXdHF_WbP2ki=qA@mail.gmail.com>
	<3174774.7AKCbYrzc6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <3174774.7AKCbYrzc6@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On 14 March 2013 03:11, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, March 12, 2013 08:55:12 AM Viresh Kumar wrote:
>> On 12 March 2013 07:38, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > One more question before I apply it.
>> >
>> > Is there any architecture/platform that will set
>> > CONFIG_CPU_FREQ_HAVE_MULTIPLE_POLICIES and keep have_multiple_policies unset
>> > at the same time?
>>
>> No, they are redundant. That's why i have been forcing to drop this patch.
>
> I see.
>
> What about having the Kconfig option alone, however?

Even that is not enough. We build multiplatform kernels and so need a
variable to be set by platform.
