From: Xiaoguang Chen <chenxg.marvell@gmail.com>
Subject: Re: [PATCH v6] Cpufreq: Fix governor start/stop race condition
Date: Wed, 19 Jun 2013 13:15:08 +0800
Message-ID: <CAFgnuDcxS53FS0w31w8k4JzyhKadfO+P12jOy5hyfVKf6pEPWg@mail.gmail.com>
References: <1371606191-5618-1-git-send-email-chenxg@marvell.com>
	<CAKohpont42JcdLH-TawNWVDJeiLNHeAWx4fgvAkyerOD=64MLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpont42JcdLH-TawNWVDJeiLNHeAWx4fgvAkyerOD=64MLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Xiaoguang Chen <chenxg@marvell.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, njiang1@marvell.com, zjwu@marvell.com, ylmao@marvell.com
List-Id: linux-pm@vger.kernel.org

2013/6/19 Viresh Kumar <viresh.kumar@linaro.org>:
> On 19 June 2013 07:13, Xiaoguang Chen <chenxg@marvell.com> wrote:
>> There are 4 CPUs and policy->cpu=cpu0, cpu1/2/3 are linked to cpu0.
>> The normal sequence is as below:
>
> I thought Rafael asked to write cpu0 as CPU0, ...

I changed "cpus" to "CPUs" as Rafael suggested(Please spell cpus as
"CPUs".  And please start sequences from capitals.)
do I need to change other "cpu" to "CPU"?
