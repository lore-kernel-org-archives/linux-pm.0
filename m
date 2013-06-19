From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5] cpufreq: fix governor start/stop race condition
Date: Wed, 19 Jun 2013 08:30:11 +0530
Message-ID: <CAKohpo=ADC_MGpXFp-QssYS70PHwBBA6qzrWhYGEqZeeaZHLDQ@mail.gmail.com>
References: <1371114118-19488-1-git-send-email-chenxg@marvell.com>
	<1912850.KuRKhn87Nf@vostro.rjw.lan>
	<CAFgnuDe1bUub92uE1H9Fc9U7AJCYL=WKdyDe2bg00yEr=kMEbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAFgnuDe1bUub92uE1H9Fc9U7AJCYL=WKdyDe2bg00yEr=kMEbQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg.marvell@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Xiaoguang Chen <chenxg@marvell.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, njiang1@marvell.com, zjwu@marvell.com, ylmao@marvell.com
List-Id: linux-pm@vger.kernel.org

On 19 June 2013 06:50, Xiaoguang Chen <chenxg.marvell@gmail.com> wrote:
> 2013/6/19 Rafael J. Wysocki <rjw@sisk.pl>:
>> On Thursday, June 13, 2013 05:01:58 PM Xiaoguang Chen wrote:
>>> cpufreq governor stop and start should be kept in sequence.
>>> If not, there will be unexpected behavior, for example:
>>>
>>> we have 4 cpus and policy->cpu=cpu0, cpu1/2/3 are linked to cpu0.
>>
>> Please spell cpus as "CPUs".  And please start sequences from capitals.
>
> Ok, thanks for the remind
>
>>
>> [Yes, it *really* is a problem.]

Just wanted to know the reasoning behind it so that I can remind
others about it and then argue :)

>>> the normal sequence is as below:
>>>
>>> 1) Current governor is userspace, one application tries to set
>>> governor to ondemand. it will call __cpufreq_set_policy in which it
>>> will stop userspace governor and then start ondemand governor.
>>
>> Do I think correctly that this is for all CPUs?
>
> From current code design, it is for all CPUs.

Why? This can be for a single cpu (which would eventually force all
others CPUs sharing policy with it).
