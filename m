From: Achin Gupta <achin.gupta@arm.com>
Subject: Re: [Question] Verification For arm64: suspend/resume implementation
Date: Tue, 24 Sep 2013 10:02:36 +0100
Message-ID: <20130924090236.GY10174@e102648.cambridge.arm.com>
References: <52327E41.1070904@marvell.com>
 <20130913144001.GA28531@e102568-lin.cambridge.arm.com>
 <524021EC.2000207@marvell.com>
 <20130923152606.GA6157@e102648.cambridge.arm.com>
 <5240F246.6050402@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34995 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab3IXJBQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2013 05:01:16 -0400
In-Reply-To: <5240F246.6050402@marvell.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leoy@marvell.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Neil Zhang <zhangwm@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Leo,

On Tue, Sep 24, 2013 at 03:00:38AM +0100, Leo Yan wrote:
>
> On 09/23/2013 11:26 PM, Achin Gupta wrote:
>
> > The foundation model (if thats what you are using) does not model an
> > ARM cpu implementation. The CPUECTLR is a cpu specific register
> > (imp. def.)  so it is not present. The caches on the Foundation Model
> > are inherently coherent so you do not need to access this register. If
> > you do then the access is treated as an illegal instruction.
> >
>
> Thx for the info. So do u mean i need use FVP Model for A53?

I think you should use the dual cluster A57_A53 Base FVP models. They
have the power controller and model the CPUECTLR.SMP bit behaviour as
well.

>
> Here have another question, ARM have the example code for boot wrapper
> which will switch from EL3 to secure EL1 rather than non-secure's EL1?

I dont' think we do but let me check. Switching to S-EL1 instead of
NS-EL1 should be a matter of _not_ setting the SCR_EL3.NS bit before
doing the exception level change (ERET).

hth,
Achin

>
> Thx,
> Leo Yan
>

