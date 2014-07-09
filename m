From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 09/14] cpufreq: cpu0: Move per-cluster initialization code
 to ->init()
Date: Wed, 9 Jul 2014 21:03:36 +0530
Message-ID: <CAKohpokAkCyBU8k7SBytfk_aszW+sumyLpf137iN7Jk3gi3vwg@mail.gmail.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
	<b26946cc4573904cd1ef0212ad053a983b547c23.1404231535.git.viresh.kumar@linaro.org>
	<53BD576F.2010408@ti.com>
	<CAKohpokz4eyw86Uxp_aA=9T9x-X=kTV=_=zx4dEuC2ZyR=3pKw@mail.gmail.com>
	<53BD5F0C.2050509@ti.com>
	<CAKohpokOMs3V250wyWB=wdW6SQEcj+RUQaQZk5MYikUKqF6Nsg@mail.gmail.com>
	<53BD5FE8.5040500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:56012 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260AbaGIPdg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 11:33:36 -0400
Received: by mail-oa0-f42.google.com with SMTP id n16so547445oag.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2014 08:33:36 -0700 (PDT)
In-Reply-To: <53BD5FE8.5040500@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@linaro.org>, Nishanth Menon <nm@ti.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas P Abraham <thomas.ab@samsung.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Sachin Kamat <spk.linux@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 9 July 2014 20:59, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> On Wednesday 09 July 2014 11:27 AM, Viresh Kumar wrote:
>> On 9 July 2014 20:56, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>>>>> We still *don't* support platforms with separate clock/voltage lines for CPUs.
>>>>> This would be done in a separate patch.
>>
>> Probably s/separate/later would be enough to make you happy ?
>>
> For reviewer, its easy if this later is "in the current series" or
> really a "later" series.

As you say  BOSS :)
