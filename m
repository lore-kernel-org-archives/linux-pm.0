From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] OPP: remove some duplicated includes
Date: Tue, 27 Nov 2018 09:35:02 +0530
Message-ID: <20181127040502.rzj2rdy3jxre5bck@vireshk-i7>
References: <20181126131838.30891-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126131838.30891-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 26-11-18, 08:18, Yangtao Li wrote:
> Some header files are included twice.It's unnecessary,
> so just remove them.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/opp/core.c          | 2 --
>  drivers/opp/cpu.c           | 1 -
>  drivers/opp/debugfs.c       | 2 --
>  drivers/opp/of.c            | 1 -
>  drivers/opp/opp.h           | 1 -
>  drivers/opp/ti-opp-supply.c | 1 -
>  6 files changed, 8 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2c2df4e4fc14..31fc2cbb9d1f 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -15,9 +15,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/errno.h>
> -#include <linux/err.h>
>  #include <linux/slab.h>
> -#include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
> diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
> index ab6d07e78945..778ac771ce93 100644
> --- a/drivers/opp/cpu.c
> +++ b/drivers/opp/cpu.c
> @@ -15,7 +15,6 @@
>  
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> -#include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index e6828e5f81b0..05670aeebecd 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -11,8 +11,6 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/debugfs.h>
> -#include <linux/device.h>
> -#include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/limits.h>
>  #include <linux/slab.h>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 5a4b47958073..ea510e350682 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -15,7 +15,6 @@
>  
>  #include <linux/cpu.h>
>  #include <linux/errno.h>
> -#include <linux/device.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/slab.h>
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 9c6544b4f4f9..558c5e638d97 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -20,7 +20,6 @@
>  #include <linux/list.h>
>  #include <linux/limits.h>
>  #include <linux/pm_opp.h>
> -#include <linux/notifier.h>
>  
>  struct clk;
>  struct regulator;
> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> index 3f4fb4dbbe33..b1d7442960e3 100644
> --- a/drivers/opp/ti-opp-supply.c
> +++ b/drivers/opp/ti-opp-supply.c
> @@ -13,7 +13,6 @@
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/notifier.h>
>  #include <linux/of_device.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>

AFAICT, none of these files have included any of the files twice directly. Yes,
they may have included some .h files (like opp.h) which may have included files
like err.h, etc. But that is fine. Each file in kernel should normally include
all its dependencies directly and should avoid depending on other .h files to do
so.

For example, kernel.h includes so many .h files, like types.h, etc. Should all
files that include kernel.h stop including types.h directly? What will happen if
kernel.h stops including types.h in future? Many other files will stop building,
because they indirectly depended on kernel.h which is incorrect in my opinion.

-- 
viresh
