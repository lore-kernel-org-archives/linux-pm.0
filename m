From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 3/6] cpufreq: sort the drivers in ARM part
Date: Wed, 06 Dec 2017 13:09:17 +0100
Message-ID: <87o9nct5w2.fsf@free-electrons.com>
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
        <20171201112508.14121-4-gregory.clement@free-electrons.com>
        <20171204091850.iamq5uslv3hv6bez@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54341 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbdLFMJ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Dec 2017 07:09:28 -0500
In-Reply-To: <20171204091850.iamq5uslv3hv6bez@vireshk-mac-ubuntu> (Viresh
        Kumar's message of "Mon, 4 Dec 2017 14:48:50 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Evan Wang <xswang@marvell.com>

Hi Viresh,
 
 On lun., déc. 04 2017, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 01-12-17, 12:25, Gregory CLEMENT wrote:
>> Keep the driver files alphabetically sorted.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/cpufreq/Makefile | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index 812f9e0d01a3..d762e76887e7 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -53,22 +53,24 @@ obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
>>  obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
>>  
>>  obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
>> +obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
>
> Shouldn't we add them in ascending order of the whole config name and not just
> CPPC_CPUFREQ ?

Here it is the object name that are sorted not the CONFIG_ name. So
cppc_cpufreq comes after brcmstb-avs-cpufreq.

Thanks,

Gregory

>
> -- 
> viresh

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
