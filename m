From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/3] cpufreq: cpufreq-dt: platform_data based proposal
Date: Tue, 21 Oct 2014 15:33:09 +0200
Message-ID: <2513404.oZkEVY1Jti@vostro.rjw.lan>
References: <1413711029-17419-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1413711029-17419-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, October 19, 2014 11:30:26 AM Thomas Petazzoni wrote:
> Hello Rafael,
> 
> As you requested, here is a new version of the cpufreq-dt patches,
> rebased on top of the latest Linus tree
> (52d589a01d4545ce1dc5c3892bb8c7b55edfe714 as I write this).
> 
> Compared to version 2:
> 
>  - Rebased on top of latest Linus tree.
> 
>  - Removed PATCH 3/4, which is meant to go through the mvebu
>    maintainer tree. I'll push it post-rc1.
> 
>  - Added Acked-by tags from Viresh, since he ACKed all the patches.
> 
> Could you take those patches and push them to 3.18 ?

I've applied the series and it is in my linux-next branch now (which means that
it should appear in linux-next proper tomorrow).

I'm going to push it for 3.18-rc2.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
