From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [Question] Verification For arm64: suspend/resume
 implementation
Date: Tue, 24 Sep 2013 14:00:13 +0100
Message-ID: <20130924130012.GE25907@arm.com>
References: <52327E41.1070904@marvell.com>
 <20130913144001.GA28531@e102568-lin.cambridge.arm.com>
 <524021EC.2000207@marvell.com>
 <20130923152606.GA6157@e102648.cambridge.arm.com>
 <5240F246.6050402@marvell.com>
 <20130924090236.GY10174@e102648.cambridge.arm.com>
 <52417C4D.1030009@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:51930 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750742Ab3IXNBF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2013 09:01:05 -0400
Content-Disposition: inline
In-Reply-To: <52417C4D.1030009@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leoy@marvell.com>
Cc: Achin Gupta <Achin.Gupta@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Yu Tang <ytang5@marvell.com>, Neil Zhang <zhangwm@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Zhou Zhu <zzhu3@marvell.com>

On Tue, Sep 24, 2013 at 12:49:33PM +0100, Leo Yan wrote:
> On 09/24/2013 05:02 PM, Achin Gupta wrote:
> > On Tue, Sep 24, 2013 at 03:00:38AM +0100, Leo Yan wrote:
> >> Here have another question, ARM have the example code for boot wrapper
> >> which will switch from EL3 to secure EL1 rather than non-secure's EL1?
> >
> > I dont' think we do but let me check. Switching to S-EL1 instead of
> > NS-EL1 should be a matter of _not_ setting the SCR_EL3.NS bit before
> > doing the exception level change (ERET).
> 
> I quick try with below patch for boot wrapper, i saw foundataion model 
> cannot boot up successfully and there have no console output; suppose 
> it's hang at some boot operations, but now foundation model cannot debug 
> low level code, so i cannot debug further more. :-(
> 
> diff --git a/boot.S b/boot.S
> index a1f25e2..2f1b867 100644
> --- a/boot.S
> +++ b/boot.S
> @@ -19,7 +19,6 @@ _start:
>          b.ne    start_ns                        // skip EL3 initialisation
> 
>          mov     x0, #0x30                       // RES1
> -       orr     x0, x0, #(1 << 0)               // Non-secure EL1
>          orr     x0, x0, #(1 << 8)               // HVC enable
>          orr     x0, x0, #(1 << 10)              // 64-bit EL2
>          msr     scr_el3, x0

You also need to make sure the boot wrapper starts the kernel in S-EL1
rather than NS-EL2.

BTW, why do you need this? There are no virtualisation features
supported on the secure side.

-- 
Catalin
