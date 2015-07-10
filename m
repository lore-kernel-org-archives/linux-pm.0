From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Fri, 10 Jul 2015 14:09:07 +0200
Message-ID: <20150710120907.GC3127@piout.net>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150710060350.GA3127@piout.net>
 <559F7AC4.6050008@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:49789 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754565AbbGJMJK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2015 08:09:10 -0400
Content-Disposition: inline
In-Reply-To: <559F7AC4.6050008@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Wu <josh.wu@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

Hi,

On 10/07/2015 at 15:56:52 +0800, Josh Wu wrote :
> I would agree with Maxime. Currently all latest chip reset function is
> compatible with the atmel,sama5d3-rstc.
> So check compatible string is enough for now.
> But of cause if we have other incompatible reset in future with new chip,
> the structure like you said is needed.

We managed to avoid using of_machine_is_compatible() in all the at91
drivers. I'd like to keep it that way. It was painful enough to remove
all those cpu_is_at91xxx calls.
Also, using it is trying to match strings and will result in longer boot
times.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
