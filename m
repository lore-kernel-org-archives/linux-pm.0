From: Leo Yan <leoy@marvell.com>
Subject: Re: [Question] Verification For arm64: suspend/resume implementation
Date: Tue, 24 Sep 2013 10:00:38 +0800
Message-ID: <5240F246.6050402@marvell.com>
References: <52327E41.1070904@marvell.com> <20130913144001.GA28531@e102568-lin.cambridge.arm.com> <524021EC.2000207@marvell.com> <20130923152606.GA6157@e102648.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41465 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752706Ab3IXCBQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2013 22:01:16 -0400
In-Reply-To: <20130923152606.GA6157@e102648.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Achin Gupta <achin.gupta@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Neil Zhang <zhangwm@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


On 09/23/2013 11:26 PM, Achin Gupta wrote:

> The foundation model (if thats what you are using) does not model an
> ARM cpu implementation. The CPUECTLR is a cpu specific register
> (imp. def.)  so it is not present. The caches on the Foundation Model
> are inherently coherent so you do not need to access this register. If
> you do then the access is treated as an illegal instruction.
>

Thx for the info. So do u mean i need use FVP Model for A53?

Here have another question, ARM have the example code for boot wrapper 
which will switch from EL3 to secure EL1 rather than non-secure's EL1?

Thx,
Leo Yan
