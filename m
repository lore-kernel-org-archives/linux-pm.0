From: Josh Wu <josh.wu@atmel.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Mon, 13 Jul 2015 11:21:44 +0800
Message-ID: <55A32EC8.4080309@atmel.com>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com> <20150710060350.GA3127@piout.net> <559F7AC4.6050008@atmel.com> <20150710120907.GC3127@piout.net> <20150710123148.GA28632@lukather> <559FEED3.5080505@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.246]:4451 "EHLO
	DVREDG02.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751605AbbGMDWF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jul 2015 23:22:05 -0400
In-Reply-To: <559FEED3.5080505@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org

On 7/11/2015 12:12 AM, Nicolas Ferre wrote:
> Le 10/07/2015 14:31, Maxime Ripard a =E9crit :
>> On Fri, Jul 10, 2015 at 02:09:07PM +0200, Alexandre Belloni wrote:
>>> Hi,
>>>
>>> On 10/07/2015 at 15:56:52 +0800, Josh Wu wrote :
>>>> I would agree with Maxime. Currently all latest chip reset functio=
n is
>>>> compatible with the atmel,sama5d3-rstc.
>>>> So check compatible string is enough for now.
>>>> But of cause if we have other incompatible reset in future with ne=
w chip,
>>>> the structure like you said is needed.
>>> We managed to avoid using of_machine_is_compatible() in all the at9=
1
>>> drivers. I'd like to keep it that way. It was painful enough to rem=
ove
>>> all those cpu_is_at91xxx calls.
>> That's your call...
>>
>>> Also, using it is trying to match strings and will result in longer=
 boot
>>> times.
>> Have you looked at the implementation of of_match_device? If that's
>> really a concern to you, you should actually avoid it.
> I agree: let's keep it simple and use of_match_device().

Ok. I will keep it as it is now:  use the (match->data !=3D=20
sama5d3_restart) for the condition.

About the of_match_device(), I prefer to keep not changing the code and=
=20
still use of_match_node().
Since of_match_device() is a wrapper for the of_match_node(). And=20
dev->of_node and at91_reset_of_match is valid, so we can just use=20
of_match_node() directly.

Is it sound okay for us?

Best Regards,
Josh Wu

>
> Bye,

