From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 1/8] PM / devfreq: tegra: Fix kHz to Hz conversion
Date: Fri, 12 Apr 2019 19:56:58 +0300
Message-ID: <ab8dfa58-5e38-7538-3d82-d762341cd1b9@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
 <20190411222914.25539-2-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411222914.25539-2-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

12.04.2019 1:29, Dmitry Osipenko пишет:
> The kHz to Hz is incorrectly converted in a few places in the code,
> this results in a wrong frequency being calculated because devfreq core
> uses OPP frequencies that are given in Hz to clamp the rate, while
> tegra-devfreq gives to the core value in kHz and then it also expects to
> receive value in kHz from the core. In a result memory freq is always set
> to a value which is close to ULONG_MAX because of the bug. Hence the EMC
> frequency is always capped to the maximum and the driver doesn't do
> anything useful. Let's provide OPP with rates in kHz since this eliminates
> few multiplies and divisions in the code. This patch was tested on Tegra30
> and Tegra124 SoC's, EMC frequency scaling works properly now.
> 
> Cc: <stable@vger.kernel.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index c89ba7b834ff..ec4ff55f5eea 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -394,7 +394,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  
>  	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
>  
> -	tegra->cur_freq = data->new_rate / KHZ;
> +	tegra->cur_freq = data->new_rate;

This was a last-minute change and it is incorrect. The cur_freq should be kept in kHz, I'll fix it up in v2 and re-test everything properly once again.
