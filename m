From: bilhuang <bilhuang@nvidia.com>
Subject: Re: [PATCH v3 2/2] cpufreq: tegra: Re-model Tegra cpufreq driver
Date: Thu, 19 Dec 2013 13:26:47 +0800
Message-ID: <52B28397.5010808@nvidia.com>
References: <1386229462-3474-1-git-send-email-bilhuang@nvidia.com>	<1386229462-3474-3-git-send-email-bilhuang@nvidia.com>	<CAKohponns4B+BPPum3EN6EuXx6U+6MzOa50gMdR1BNBtxMNf0Q@mail.gmail.com>	<52B02D04.4050905@nvidia.com>	<CAKohpom0n8P8goQnsgBnWJwyqCVv_FRX3xKvO1yFW0VUMpMW8w@mail.gmail.com>	<52B187F5.7020105@nvidia.com> <CAKohpokwhYC4FGnhpZPOGuJ2AM_7vygNk+3S+VpA_eXAexQX7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1624 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab3LSF01 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2013 00:26:27 -0500
In-Reply-To: <CAKohpokwhYC4FGnhpZPOGuJ2AM_7vygNk+3S+VpA_eXAexQX7g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 12/18/2013 10:39 PM, Viresh Kumar wrote:
> On 18 December 2013 17:03, bilhuang <bilhuang@nvidia.com> wrote:
>> cpufreq-cpu0 driver will call regulator_set_voltage_tol() directly according
>> to the pre-defined OPP freq/volt pairs, the regulator drivers could be
>> shared by other SoC so is not suitable to handle this, or do I
>> misunderstand?
>
> In case regulator's driver is shared, then you can probably add another
> virtual regulator for CPU which would have the special code you want.
>
I'm not sure virtual regulator for CPU is a good idea, in addition to 
that, we don't have a single SoC OPP table, we need several which are 
speedo-id and process-id dependant, but generic cpufreq-cpu0 is assuming 
there is only one statically, for some SoC the frequency table is not 
fixed, they are created at runtime combining our fast and slow CPU 
frequency table and dvfs table. So I'm really not sure is it worth 
adding so many tweaks in order to use the generic cpufreq-cpu0 driver.
