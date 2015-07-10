From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Fri, 10 Jul 2015 18:12:03 +0200
Message-ID: <559FEED3.5080505@atmel.com>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com> <20150710060350.GA3127@piout.net> <559F7AC4.6050008@atmel.com> <20150710120907.GC3127@piout.net> <20150710123148.GA28632@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:35547 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbbGJQNR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2015 12:13:17 -0400
In-Reply-To: <20150710123148.GA28632@lukather>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Josh Wu <josh.wu@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org

Le 10/07/2015 14:31, Maxime Ripard a =E9crit :
> On Fri, Jul 10, 2015 at 02:09:07PM +0200, Alexandre Belloni wrote:
>> Hi,
>>
>> On 10/07/2015 at 15:56:52 +0800, Josh Wu wrote :
>>> I would agree with Maxime. Currently all latest chip reset function=
 is
>>> compatible with the atmel,sama5d3-rstc.
>>> So check compatible string is enough for now.
>>> But of cause if we have other incompatible reset in future with new=
 chip,
>>> the structure like you said is needed.
>>
>> We managed to avoid using of_machine_is_compatible() in all the at91
>> drivers. I'd like to keep it that way. It was painful enough to remo=
ve
>> all those cpu_is_at91xxx calls.
>=20
> That's your call...
>=20
>> Also, using it is trying to match strings and will result in longer =
boot
>> times.
>=20
> Have you looked at the implementation of of_match_device? If that's
> really a concern to you, you should actually avoid it.

I agree: let's keep it simple and use of_match_device().

Bye,
--=20
Nicolas Ferre
