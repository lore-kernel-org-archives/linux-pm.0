From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6] Cpufreq: Fix governor start/stop race condition
Date: Wed, 19 Jun 2013 10:46:57 +0530
Message-ID: <CAKohpo=t+bVdPpqVoBOGByeNguLgyLqoE3sLwjfDFAeQArbuMA@mail.gmail.com>
References: <1371606191-5618-1-git-send-email-chenxg@marvell.com>
	<CAKohpont42JcdLH-TawNWVDJeiLNHeAWx4fgvAkyerOD=64MLQ@mail.gmail.com>
	<CAFgnuDcxS53FS0w31w8k4JzyhKadfO+P12jOy5hyfVKf6pEPWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAFgnuDcxS53FS0w31w8k4JzyhKadfO+P12jOy5hyfVKf6pEPWg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg.marvell@gmail.com>
Cc: Xiaoguang Chen <chenxg@marvell.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, njiang1@marvell.com, zjwu@marvell.com, ylmao@marvell.com
List-Id: linux-pm@vger.kernel.org

On 19 June 2013 10:45, Xiaoguang Chen <chenxg.marvell@gmail.com> wrote:
> 2013/6/19 Viresh Kumar <viresh.kumar@linaro.org>:
>> On 19 June 2013 07:13, Xiaoguang Chen <chenxg@marvell.com> wrote:
>>> There are 4 CPUs and policy->cpu=cpu0, cpu1/2/3 are linked to cpu0.
>>> The normal sequence is as below:
>>
>> I thought Rafael asked to write cpu0 as CPU0, ...
>
> I changed "cpus" to "CPUs" as Rafael suggested(Please spell cpus as
> "CPUs".  And please start sequences from capitals.)
> do I need to change other "cpu" to "CPU"?

I am not really sure what he meant by "sequence", but I guess its regarding
cpu0, cpu1, cpu2, etc... and not cpu .
