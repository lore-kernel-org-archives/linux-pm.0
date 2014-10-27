From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 0/3] cpufreq: cpufreq-dt: platform_data based proposal
Date: Mon, 27 Oct 2014 14:54:30 +0100
Message-ID: <CAMuHMdW3v+-M550A1aNRDO_JZCgOKD1xjJOSAA-e7uFUzLU-1Q@mail.gmail.com>
References: <1413711029-17419-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<2513404.oZkEVY1Jti@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <2513404.oZkEVY1Jti@vostro.rjw.lan>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 21, 2014 at 3:33 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Sunday, October 19, 2014 11:30:26 AM Thomas Petazzoni wrote:
>> Hello Rafael,
>>
>> As you requested, here is a new version of the cpufreq-dt patches,
>> rebased on top of the latest Linus tree
>> (52d589a01d4545ce1dc5c3892bb8c7b55edfe714 as I write this).
>>
>> Compared to version 2:
>>
>>  - Rebased on top of latest Linus tree.
>>
>>  - Removed PATCH 3/4, which is meant to go through the mvebu
>>    maintainer tree. I'll push it post-rc1.
>>
>>  - Added Acked-by tags from Viresh, since he ACKed all the patches.
>>
>> Could you take those patches and push them to 3.18 ?
>
> I've applied the series and it is in my linux-next branch now (which means that
> it should appear in linux-next proper tomorrow).
>
> I'm going to push it for 3.18-rc2.

Unfortunately this caused a regression (crash). Fix available in
https://lkml.org/lkml/2014/10/27/361

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
