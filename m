From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: conservative: fix requested_freq reduction issue
Date: Fri, 8 Nov 2013 10:17:46 +0530
Message-ID: <CAKohpo=Fm+_8nOnZAE_kDu8p7NgaAQY_-rvoxsHo+d3EQyvBOA@mail.gmail.com>
References: <1383791330-8289-1-git-send-email-chenxg@marvell.com>
	<CAKohpo=2xjR=nr5hyMg9bve5_uVbV79R2FTxks0bLmL7kNV9Mg@mail.gmail.com>
	<4433736.xh14GOaN7a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <4433736.xh14GOaN7a@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Xiaoguang Chen <chenxg@marvell.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Xiaoguang Chen <chenxg.marvell@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 8 November 2013 00:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, November 07, 2013 10:39:38 AM Viresh Kumar wrote:

>> We need another patch for fixing the other part of code where we
>> increase freq..
>> We need to replace:
>>
>> if (dbs_info->requested_freq == policy->max)
>>     return;
>>
>> with
>>
>> if (dbs_info->requested_freq >= policy->max)
>>     return;
>>
>> So, that we don't run unnecessary code :)
>
> Care to prepare a patch?

I wanted to give a chance to Xiaoguang to generate a patch for us :)
Lets wait for his reply, otherwise I will do it.
