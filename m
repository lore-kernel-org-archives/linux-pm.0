From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 5/5] thermal: cpu_cooling: update the cpu device when
 cpufreq updates the policy cpu
Date: Tue, 03 Mar 2015 15:33:43 +0000
Message-ID: <54F5D457.30706@arm.com>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>	<1425316643-31991-6-git-send-email-javi.merino@arm.com>	<CAOh2x=m9c-gOYcesgh+4oc9NucFdD1y0Mcit5gPwLxGFt__Lng@mail.gmail.com>	<54F5941F.6030402@arm.com>	<CAKohpon3sn_4aX7g+=LFdY-AgYrWdFCWtyethJtVMEK=Dw9Xbw@mail.gmail.com>	<54F59DEF.3020700@arm.com>	<CAKohponB3cNXT8p=SqrfpGEPjLpeE=tnzUVOiabV8hEfBMb8rQ@mail.gmail.com>	<54F5CEBC.1070303@arm.com>	<CAPKp9ubM2PSzHUcqM7f=0LC9P=b-r5hjgZmoi0nRrr+Gk2miuw@mail.gmail.com> <CAKohpo=rJf17NaEO3O9KACQj0vXuKJwH_KGMxpBO4jtuZhk+Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=rJf17NaEO3O9KACQj0vXuKJwH_KGMxpBO4jtuZhk+Xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>, Javi Merino <Javi.Merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Mark Brown <broonie@kernel.org>, Jon Medhurst <tixy@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 03/03/15 15:30, Viresh Kumar wrote:
> On 3 March 2015 at 20:56, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> You can use any_online_cpu(..) instead of cpumask_any IMO
>
> What about policy->cpu  ? :)
>

We can, was not sure if they have access to policy in their thermal
driver. Just the first thought seeing one line of the code posted :)

Regards,
Sudeep
