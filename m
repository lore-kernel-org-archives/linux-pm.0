From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/7] drivers/cpufreq: change CONFIG_6xx to
 CONFIG_PPC_BOOK3S_32
Date: Mon, 19 Nov 2018 09:34:23 +0530
Message-ID: <20181119040423.pbfuszycad66e2qr@vireshk-i7>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17-11-18, 10:24, Christophe Leroy wrote:
> Today, powerpc has three CONFIG labels which means exactly the same:
> - CONFIG_6xx
> - CONFIG_PPC_BOOK3S_32
> - CONFIG_PPC_STD_MMU_32
> 
> By consistency with PPC64, CONFIG_PPC_BOOK3S_32 is the preferred one.
> Using a label with includes _PPC_ also makes it clearer that it is
> linked to powerpc.
> 
> In preparation of the removal of CONFIG_6xx, this patch replaces it
> by CONFIG_PPC_BOOK3S_32
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/cpufreq/pmac32-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
> index 61ae06ca008e..52f0d91d30c1 100644
> --- a/drivers/cpufreq/pmac32-cpufreq.c
> +++ b/drivers/cpufreq/pmac32-cpufreq.c
> @@ -128,7 +128,7 @@ static int cpu_750fx_cpu_speed(int low_speed)
>  			mtspr(SPRN_HID2, hid2);
>  		}
>  	}
> -#ifdef CONFIG_6xx
> +#ifdef CONFIG_PPC_BOOK3S_32
>  	low_choose_750fx_pll(low_speed);
>  #endif
>  	if (low_speed == 1) {
> @@ -166,7 +166,7 @@ static int dfs_set_cpu_speed(int low_speed)
>  	}
>  
>  	/* set frequency */
> -#ifdef CONFIG_6xx
> +#ifdef CONFIG_PPC_BOOK3S_32
>  	low_choose_7447a_dfs(low_speed);
>  #endif
>  	udelay(100);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
