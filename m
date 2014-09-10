From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: cpufreq-dt: remove warning about regulators
Date: Wed, 10 Sep 2014 16:00:38 +0530
Message-ID: <CAKohpokpmoyiDwY-1P3ujetfddVAZ=1A4GD+YRvFOfT5L7CD7g@mail.gmail.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1410342112-13264-5-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410342112-13264-5-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

On 10 September 2014 15:11, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> The cpufreq-dt driver tries to get a regulator for each CPU. This
> regulator is optional, but when not present, a scary message "failed
> to get cpuX regulator" is displayed. Since the regulator is really
> optional, we cannot sanely display any useful message, so this commit
> simply gets rid of this problematic message.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 35d396e..8060022 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -149,9 +149,6 @@ try_again:
>                         reg = reg_cpu;
>                         goto try_again;
>                 }
> -
> -               dev_warn(cpu_dev, "failed to get cpu%d regulator: %ld\n",
> -                        cpu, PTR_ERR(cpu_reg));

What about converting it to dev_dbg() instead?
