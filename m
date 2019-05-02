From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] power: supply: core: fix clang -Wunsequenced
Date: Thu, 2 May 2019 11:00:31 -0700
Message-ID: <CAKwvOdkCesLHCFy5vD3=KUCRALe-u_TKMa3NGZBn=HuA1R_95g@mail.gmail.com>
References: <20190502012704.12505-1-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502012704.12505-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: sre@kernel.org, Nathan Chancellor <natechancellor@gmail.com>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 1, 2019 at 6:28 PM Phong Tran <tranmanphong@gmail.com> wrote:
>
> The increment operator of  pointer in be32_to_cpu() is not explicitly.
> It made the warning from clang:
>
> drivers/power/supply/power_supply_core.c:674:36: error: multiple
> unsequenced modifications to 'list' [-Werror,-Wunsequenced]
> drivers/power/supply/power_supply_core.c:675:41: error: multiple
> unsequenced modifications to 'list' [-Werror,-Wunsequenced]
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/460
>
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  drivers/power/supply/power_supply_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index c917a8b43b2b..7cc6f5fac0d0 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -665,8 +665,10 @@ int power_supply_get_battery_info(struct power_supply *psy,
>                 }
>
>                 for (i = 0; i < tab_len; i++) {
> -                       table[i].ocv = be32_to_cpu(*list++);
> -                       table[i].capacity = be32_to_cpu(*list++);
> +                       table[i].ocv = be32_to_cpu(*list);
> +                       list++;
> +                       table[i].capacity = be32_to_cpu(*list);
> +                       list++;

I prefer preincrement/predecrement to postincrement/postdecrement
unless absolutely necessary, but it really doesn't matter in this
case.  Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
