From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/3] mfd: max77693: Add defines for charger current
 control
Date: Tue, 27 Sep 2016 10:06:46 +0200
Message-ID: <20160927080646.GB4394@kozik-lap>
References: <1474932670-11953-1-git-send-email-wolfgit@wiedmeyer.de>
 <1474932670-11953-2-git-send-email-wolfgit@wiedmeyer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36646 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754022AbcI0IGv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2016 04:06:51 -0400
Content-Disposition: inline
In-Reply-To: <1474932670-11953-2-git-send-email-wolfgit@wiedmeyer.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Cc: krzk@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com, broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 27, 2016 at 01:31:08AM +0200, Wolfgang Wiedmeyer wrote:
> This prepares for an updated regulator and charger driver. The defines
> are needed to set the maximum input current and the fast charge
> current.
> 
> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>

This shouldn't be separate patch, because:
1. You are touching later power and regulator so this patch should be
applied to one and then pulled by other... a lot of unneeded work.
2. It is difficult to find which new code is needed for which driver.

Simpler approach might work - when changing the regulator or psy driver,
just change the header as needed. Unless there are conflicts and both of
them need the same?

Best regards,
Krzysztof

> ---
>  include/linux/mfd/max77693-private.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
> index 3c7a63b..ca18344 100644
> --- a/include/linux/mfd/max77693-private.h
> +++ b/include/linux/mfd/max77693-private.h
> @@ -222,6 +222,9 @@ enum max77693_charger_battery_state {
>  #define CHG_CNFG_00_CHG_MASK		0x1
>  #define CHG_CNFG_00_BUCK_MASK		0x4
>  
> +/* MAX77693 CHG_CNFG_02 register */
> +#define CHG_CNFG_02_CC_MASK		0x3F
> +
>  /* MAX77693_CHG_REG_CHG_CNFG_01 register */
>  #define CHG_CNFG_01_FCHGTIME_SHIFT	0
>  #define CHG_CNFG_01_CHGRSTRT_SHIFT	4
> @@ -258,6 +261,10 @@ enum max77693_charger_battery_state {
>  
>  /* MAX77693 CHG_CNFG_09 Register */
>  #define CHG_CNFG_09_CHGIN_ILIM_MASK	0x7F
> +#define CHG_CNFG_09_CHGIN_ILIM_500_MAX	500000
> +#define CHG_CNFG_09_CHGIN_ILIM_500_MIN	470000
> +#define CHG_CNFG_09_CHGIN_ILIM_0_MAX	60000
> +#define CHG_CNFG_09_CHGIN_ILIM_0_MIN	0
>  
>  /* MAX77693 CHG_CTRL Register */
>  #define SAFEOUT_CTRL_SAFEOUT1_MASK	0x3
> -- 
> 2.8.0.rc3
> 
