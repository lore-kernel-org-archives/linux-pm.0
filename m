From: Leo Yan <leoy@marvell.com>
Subject: Re: [Question] Verification For arm64: suspend/resume implementation
Date: Tue, 24 Sep 2013 19:49:33 +0800
Message-ID: <52417C4D.1030009@marvell.com>
References: <52327E41.1070904@marvell.com> <20130913144001.GA28531@e102568-lin.cambridge.arm.com> <524021EC.2000207@marvell.com> <20130923152606.GA6157@e102648.cambridge.arm.com> <5240F246.6050402@marvell.com> <20130924090236.GY10174@e102648.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57191 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751038Ab3IXLuM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2013 07:50:12 -0400
In-Reply-To: <20130924090236.GY10174@e102648.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Achin Gupta <achin.gupta@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Neil Zhang <zhangwm@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


On 09/24/2013 05:02 PM, Achin Gupta wrote:
> Hi Leo,
>
> On Tue, Sep 24, 2013 at 03:00:38AM +0100, Leo Yan wrote:
>>
>> On 09/23/2013 11:26 PM, Achin Gupta wrote:
>>
>>> The foundation model (if thats what you are using) does not model an
>>> ARM cpu implementation. The CPUECTLR is a cpu specific register
>>> (imp. def.)  so it is not present. The caches on the Foundation Model
>>> are inherently coherent so you do not need to access this register. If
>>> you do then the access is treated as an illegal instruction.
>>>
>>
>> Thx for the info. So do u mean i need use FVP Model for A53?
>
> I think you should use the dual cluster A57_A53 Base FVP models. They
> have the power controller and model the CPUECTLR.SMP bit behaviour as
> well.
>

Hmm...So far i only focus on A53; actually i have built FVP model for 
A53x4 cores, but now are pending for the license. If this model can 
support power controller and SMP bit, it will let my work much clean.

>>
>> Here have another question, ARM have the example code for boot wrapper
>> which will switch from EL3 to secure EL1 rather than non-secure's EL1?
>
> I dont' think we do but let me check. Switching to S-EL1 instead of
> NS-EL1 should be a matter of _not_ setting the SCR_EL3.NS bit before
> doing the exception level change (ERET).

I quick try with below patch for boot wrapper, i saw foundataion model 
cannot boot up successfully and there have no console output; suppose 
it's hang at some boot operations, but now foundation model cannot debug 
low level code, so i cannot debug further more. :-(

diff --git a/boot.S b/boot.S
index a1f25e2..2f1b867 100644
--- a/boot.S
+++ b/boot.S
@@ -19,7 +19,6 @@ _start:
         b.ne    start_ns                        // skip EL3 initialisation

         mov     x0, #0x30                       // RES1
-       orr     x0, x0, #(1 << 0)               // Non-secure EL1
         orr     x0, x0, #(1 << 8)               // HVC enable
         orr     x0, x0, #(1 << 10)              // 64-bit EL2
         msr     scr_el3, x0


Thx,
Leo Yan

