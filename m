From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv2 4/4] cpufreq: cpufreq-dt: adjust message related to regulators
Date: Wed, 10 Sep 2014 17:53:56 +0530
Message-ID: <CAKohpo=-NXx3roypCxbkemBe7Zfi3d53-buA5UQUma-CpVySYQ@mail.gmail.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1410350908-11316-5-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:39278 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaIJMX4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 08:23:56 -0400
Received: by mail-oi0-f46.google.com with SMTP id g201so3737914oib.33
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2014 05:23:56 -0700 (PDT)
In-Reply-To: <1410350908-11316-5-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>

On 10 September 2014 17:38, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> The cpufreq-dt driver tries to get a regulator for each CPU. This
> regulator is optional, but when not present, a scary message "failed
> to get cpuX regulator" is displayed. To solve this, we reduce the
> severity of the message from dev_warn() to dev_dbg() and we reword the
> message to not be as scary.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 987bbfa..b14628f 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -147,8 +147,8 @@ try_again:
>                         goto try_again;
>                 }
>
> -               dev_warn(cpu_dev, "failed to get cpu%d regulator: %ld\n",
> -                        cpu, PTR_ERR(cpu_reg));
> +               dev_dbg(cpu_dev, "no regulator for cpu%d: %ld\n",
> +                       cpu, PTR_ERR(cpu_reg));
>         }
>
>         cpu_clk = clk_get(cpu_dev, NULL);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
