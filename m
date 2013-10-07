From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 27/92] cpufreq: s3cx4xx: Use generic cpufreq routines
Date: Mon, 7 Oct 2013 08:29:31 +0530
Message-ID: <CAKohpokeS2OuEc8xxvSYp=FZGibFOTruAy3uvN689UP7_KJKWg@mail.gmail.com>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
	<d43483a3c36ca89e75975485762f7ae9f75c8538.1380783079.git.viresh.kumar@linaro.org>
	<0d8a01cec172$7a008510$6e018f30$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <0d8a01cec172$7a008510$6e018f30$@org>
Sender: cpufreq-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05/10/2013, Kukjin Kim <kgene@kernel.org> wrote:
> Viresh Kumar wrote:
>>
>> Most of the CPUFreq drivers do similar things in .exit() and .verify()
>> routines
>> and .attr. So its better if we have generic routines for them which can
>> be
>> used
>> by cpufreq drivers then.
>>
>> This patch uses these generic routines for this driver.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>
> BTW, would be helpful to me if you could add regarding maintainers in cc on
> the common stuff of this changes :-)

I forgot to add --supress-cc while sending these patches.. These
weren't out for review, but for applying.. :)

I have already sent the common stuff cc'd to all maintainers earlier..
