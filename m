From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] ARM: at91: cpuidle: Move driver to drivers/cpuidle
Date: Mon, 14 Oct 2013 12:20:03 +0200
Message-ID: <3135182.xhXUMRLLGy@amdc1032>
References: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org>
 <20131013111945.0251a3cc@skate> <525A732D.3080708@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51065 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab3JNKUK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 06:20:10 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MUN005G2M1GYVS0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 14 Oct 2013 19:20:09 +0900 (KST)
In-reply-to: <525A732D.3080708@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org


Hi Daniel,

On Sunday, October 13, 2013 12:17:17 PM Daniel Lezcano wrote:
> On 10/13/2013 11:19 AM, Thomas Petazzoni wrote:
> > Dear Daniel Lezcano,
> >
> > On Sat, 12 Oct 2013 17:51:39 +0200, Daniel Lezcano wrote:
> >
> >> +config ARM_AT91_CPUIDLE
> >> +        bool "Cpu Idle Driver for the AT91 processors"
> >
> > Nitpick: indentation is done with spaces here, while it should be one
> > tab.
> 
> Ah, right. Fixed for the V2.

Could you also please add 'default y' to preserve the old behavior?
(the at91 cpuidle support was always built-in for CONFIG_CPU_IDLE=y)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

