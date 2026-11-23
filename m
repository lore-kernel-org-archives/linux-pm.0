Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.154.119.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472509;
	b=tmqzOAvdaMYW/z+C1XWWdFInnJ/Y1HMGBw6nVAw9yCl1t+u9wfPthl+jqZx4htP3kOWe
	 qSYLQgBQLmNShSsOdIPJG5AVh1jaYprL9VvXYfUNGUZs8AVZZOgldCvOkurGZImqvXkg2
	 PL+7mBOPxISVyJ3n2FLv73k8uwnN/cHLHXYKJjkZrOGchpbZwhu4ksC20FZwbntD+oIEq
	 oxiv2WMpEz7P6IHhHxPOxLe0JCO2jR0wmz6uefltOPR8VgOvnMsRdA6rNfc6BZWWZ6kgo
	 pdDQFLuePP+zysASA8DCWV9Gf/Il7S7WQl2YeAB12RGpcO+Lxs8EZ8HEU01RpOzuCPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472509;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=M/dPNEWQK09q7JbjfKH7MJ1mwiktjZdxAxMD410YALQ=;
	b=Alfk9rMm/yNWEaB6AaE8XfgPQhh+J5utkdQLX7ZE597RJguYDza3MyZXAFrsmTomzZF9
	 QYadUCUQkHC1DW1MHep9pvQQoZDA6nZk6P6s8cYguzivINxlzhj+H6rq/ocD2JkXWdfdP
	 ryr+8qN+YKkvIRoyCi+ncxMDTkZL/LaHpVBE2L5Vs/+YnuTkkVrV1fsrd1gGtzNVABoGw
	 oncSGvvB8RlpW1HRmjwxTfKXQXyKo8hrlIqRo8xnJAI6acHXc8BJCg5jiHpbmFHrFsZto
	 uQ75Ci2b2N46csNDzgKiSgiz4NDKOklqpD2qyrLs/oXopyxPbGvCrbBwDH2k/VbWuKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aurel32.net;
	spf=pass smtp.mailfrom=aurel32.net;
	dkim=pass header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=y5Qgq2rg;
	arc=none smtp.remote-ip=195.154.119.183
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8730606A32C;
	Mon, 23 Nov 2026 22:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8730606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=y5Qgq2rg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=M/dPNEWQK09q7JbjfKH7MJ1mwiktjZdxAxMD410YALQ=; b=y5Qgq2rgrcm/D3WJARApnsHXJK
	RJM0D9qlkJNg2cvotSj9SwbQDeud8fkEHEP89lRYc98kuvvruXkqlV5gDg2g02fkTnHq6lBjWXjEr
	p6uUh/NBcRdw1yZDa5iCsO2c2p4+BcKyeP31XJbbGL5iVndPP3Wqn4GvWOmp0aTtuuiFWUugxMy4U
	DJ+wFIyxhkRnvTWBYd2+tg/G3TNixu8qZBlXQ0R+ONLT5E2sv5RzY//5ibbLjonYRSVKs8rg3Sbry
	oIejOzjkztwW8oY622OO9f/IA7+VjvTjBf3L/vB9/g1MPg+NElI/gjnMEMObCtVSm9kcsKcTfctT/
	hNMzM6iw==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1xVcPt-00000007bSR-3nqY;
	Mon, 23 Nov 2026 23:21:41 +0100
Date: Mon, 23 Nov 2026 23:21:39 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH v2 2/3] riscv: sbi: Register SRST handlers with firmware
 priority
Message-ID: <awS8c3RFkv1D07dc@aurel32.net>
Mail-Followup-To: Anand Moon <linux.amoon@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
References: <20261118104935.1716-1-linux.amoon@gmail.com>
 <20261118104935.1716-2-linux.amoon@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118104935.1716-2-linux.amoon@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

On 2026-11-18 16:19, Anand Moon wrote:
> The SBI System Reset (SRST) extension currently registers its poweroff
> handler using register_platform_power_off(), which assigns it a lower
> priority than the default PMIC poweroff handlers.
> 
> On platforms where OpenSBI handles system poweroff, a PMIC handler may
> run first and perform I2C-backed regmap operations in atomic context,
> triggering invalid wait context and scheduling-while-atomic warnings.
> 
> Register both SBI SRST restart and poweroff handlers using
> register_sys_off_handler() with SYS_OFF_PRIO_FIRMWARE. This gives firmware
> handlers precedence over default-priority PMIC handlers and avoids
> board-specific workarounds in individual PMIC drivers.
> 
> Defer handler registration to a device initcall because sbi_init() runs
> during early architecture initialization, before dynamic memory
> allocation required by register_sys_off_handler() is available.
> 
> Preserve warm and cold reboot selection, retain the existing legacy
> poweroff fallback, and report handler registration failures.
> 
> Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Suggested-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> New patch:
>    Link: https://lore.kernel.org/all/20261110061429.2036-2-linux.amoon@gmail.com/
> ---
>  arch/riscv/kernel/sbi.c | 43 +++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index af1ccea222f1..ab6e5bf25411 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -512,23 +512,50 @@ static void sbi_srst_reset(unsigned long type, unsigned long reason)
>  		__func__, type, reason);
>  }
>  
> -static int sbi_srst_reboot(struct notifier_block *this,
> -			   unsigned long mode, void *cmd)
> +static int sbi_srst_reboot(struct sys_off_data *data)
>  {
> -	sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
> +	sbi_srst_reset((reboot_mode == REBOOT_WARM ||
> +			reboot_mode == REBOOT_SOFT) ?
>  		       SBI_SRST_RESET_TYPE_WARM_REBOOT :
>  		       SBI_SRST_RESET_TYPE_COLD_REBOOT,
>  		       SBI_SRST_RESET_REASON_NONE);
> +
>  	return NOTIFY_DONE;
>  }
>  
> -static struct notifier_block sbi_srst_reboot_nb;
> -
> -static void sbi_srst_power_off(void)
> +static int sbi_srst_power_off(struct sys_off_data *data)
>  {
>  	sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
>  		       SBI_SRST_RESET_REASON_NONE);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int __init sbi_srst_sys_off_init(void)
> +{
> +	struct sys_off_handler *handler;
> +
> +	if (sbi_spec_version < sbi_mk_version(0, 3) ||
> +	    !sbi_probe_extension(SBI_EXT_SRST))
> +		return 0;
> +
> +	handler = register_sys_off_handler(SYS_OFF_MODE_RESTART,
> +					   SYS_OFF_PRIO_FIRMWARE,
> +					   sbi_srst_reboot, NULL);
> +	if (IS_ERR(handler))
> +		pr_warn("Failed to register SBI SRST restart handler: %ld\n",
> +			PTR_ERR(handler));
> +
> +	handler = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> +					   SYS_OFF_PRIO_FIRMWARE,
> +					   sbi_srst_power_off, NULL);
> +	if (IS_ERR(handler))
> +		pr_warn("Failed to register SBI SRST poweroff handler: %ld\n",
> +			PTR_ERR(handler));
> +
> +	return 0;
>  }
> +device_initcall(sbi_srst_sys_off_init);
>  
>  /**
>   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
> @@ -677,11 +704,7 @@ void __init sbi_init(void)
>  		if (sbi_spec_version >= sbi_mk_version(0, 3) &&
>  		    sbi_probe_extension(SBI_EXT_SRST)) {
>  			pr_info("SBI SRST extension detected\n");
> -			register_platform_power_off(sbi_srst_power_off);
>  			srst_power_off = true;
> -			sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
> -			sbi_srst_reboot_nb.priority = 192;
> -			register_restart_handler(&sbi_srst_reboot_nb);
>  		}
>  		if (sbi_spec_version >= sbi_mk_version(2, 0) &&
>  		    sbi_probe_extension(SBI_EXT_DBCN) > 0) {

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
