From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: mt8173: Mark mt8173_cpufreq_driver_init as
 __init
Date: Thu, 2 Mar 2017 16:36:51 +0530
Message-ID: <20170302110651.GC13760@vireshk-i7>
References: <20170302110345.184924-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170302110345.184924-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Yidi Lin <yidi.lin@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02-03-17, 19:03, Daniel Kurtz wrote:
> This function is only called once at boot by device_initcall(), so mark
> it as __init.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/cpufreq/mt8173-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
