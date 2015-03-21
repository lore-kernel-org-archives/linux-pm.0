From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V2 3/8] ARM64: cpuidle: Replace cpu_suspend by the common
 ARM/ARM64 function
Date: Sat, 21 Mar 2015 20:56:27 +0000
Message-ID: <20150321205627.GG22354@red-moon>
References: <1426704372-20406-1-git-send-email-daniel.lezcano@linaro.org>
 <1426704372-20406-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426704372-20406-4-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 18, 2015 at 06:46:07PM +0000, Daniel Lezcano wrote:
> Call the common ARM/ARM64 'arm_cpuidle_suspend' instead of cpu_suspend function
> which is specific to ARM64.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Kevin Hilman <khilman@linaro.org>
> Acked-by: Rob Herring <robherring2@gmail.com>

I think that's ok even though I would like with this set to stop
churning out arm64 cpuidle related functions renaming, so:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> ---
>  drivers/cpuidle/cpuidle-arm64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> index 39a2c62..0cea244 100644
> --- a/drivers/cpuidle/cpuidle-arm64.c
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -49,7 +49,7 @@ static int arm64_enter_idle_state(struct cpuidle_device *dev,
>  		 * call the CPU ops suspend protocol with idle index as a
>  		 * parameter.
>  		 */
> -		ret = cpu_suspend(idx);
> +		arm_cpuidle_suspend(idx);
>  
>  		cpu_pm_exit();
>  	}
> -- 
> 1.9.1
> 
> 
