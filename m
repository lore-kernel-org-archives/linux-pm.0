From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V2 12/12] MIPS: Loongson: Make CPUFreq usable for
 Loongson-3
Date: Tue, 11 Nov 2014 11:57:48 +0100
Message-ID: <20141111105748.GK27259@linux-mips.org>
References: <1415081928-25899-1-git-send-email-chenhc@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:39115 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbaKKK55 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Nov 2014 05:57:57 -0500
Received: from localhost.localdomain ([127.0.0.1]:57573 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013367AbaKKK5zReWly (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Nov 2014 11:57:55 +0100
Content-Disposition: inline
In-Reply-To: <1415081928-25899-1-git-send-email-chenhc@lemote.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>, "Steven J. Hill" <Steven.Hill@imgtec.com>, linux-mips@linux-mips.org, linux-pm@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Hongliang Tao <taohl@lemote.com>

On Tue, Nov 04, 2014 at 02:18:48PM +0800, Huacai Chen wrote:

> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index c94c4e9..01d676a 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -136,7 +136,8 @@ asmlinkage void start_secondary(void)
>  	calibrate_delay();
>  	preempt_disable();
>  	cpu = smp_processor_id();
> -	cpu_data[cpu].udelay_val = loops_per_jiffy;
> +	if (!cpu_data[cpu].udelay_val)
> +		cpu_data[cpu].udelay_val = loops_per_jiffy;

Why this?  Is the idea that the value of loops_per_jiffy which was set
on bootup may no longer match the actual clock frequency?

  Ralf
