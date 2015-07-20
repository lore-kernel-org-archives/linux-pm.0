From: Josh Wu <josh.wu@atmel.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Mon, 20 Jul 2015 17:13:13 +0800
Message-ID: <55ACBBA9.1090607@atmel.com>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com> <20150710060350.GA3127@piout.net> <559F7AC4.6050008@atmel.com> <20150710120907.GC3127@piout.net> <20150710123148.GA28632@lukather> <559FEED3.5080505@atmel.com> <55A32EC8.4080309@atmel.com> <20150720075231.GQ28632@lukather> <55ACB2C9.5070701@atmel.com> <55ACB506.9080505@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:41124 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323AbbGTJOp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 05:14:45 -0400
In-Reply-To: <55ACB506.9080505@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Fabian Frederick <fabf@skynet.be>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Ben Dooks <ben.dooks@codethink.co.uk>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Guenter Roeck <linux@roeck-us.net>

On 7/20/2015 4:44 PM, Josh Wu wrote:
> On 7/20/2015 4:35 PM, Josh Wu wrote:
>> Hi, Maxime
>>
>> On 7/20/2015 3:52 PM, Maxime Ripard wrote:
>>> Hi Josh,
>>>
>>> On Mon, Jul 13, 2015 at 11:21:44AM +0800, Josh Wu wrote:
>>>> On 7/11/2015 12:12 AM, Nicolas Ferre wrote:
>>>>> Le 10/07/2015 14:31, Maxime Ripard a =E9crit :
>>>>>> On Fri, Jul 10, 2015 at 02:09:07PM +0200, Alexandre Belloni wrot=
e:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 10/07/2015 at 15:56:52 +0800, Josh Wu wrote :
>>>>>>>> I would agree with Maxime. Currently all latest chip reset=20
>>>>>>>> function is
>>>>>>>> compatible with the atmel,sama5d3-rstc.
>>>>>>>> So check compatible string is enough for now.
>>>>>>>> But of cause if we have other incompatible reset in future wit=
h=20
>>>>>>>> new chip,
>>>>>>>> the structure like you said is needed.
>>>>>>> We managed to avoid using of_machine_is_compatible() in all the=
=20
>>>>>>> at91
>>>>>>> drivers. I'd like to keep it that way. It was painful enough to=
=20
>>>>>>> remove
>>>>>>> all those cpu_is_at91xxx calls.
>>>>>> That's your call...
>>>>>>
>>>>>>> Also, using it is trying to match strings and will result in=20
>>>>>>> longer boot
>>>>>>> times.
>>>>>> Have you looked at the implementation of of_match_device? If tha=
t's
>>>>>> really a concern to you, you should actually avoid it.
>>>>> I agree: let's keep it simple and use of_match_device().
>>>> Ok. I will keep it as it is now:  use the (match->data !=3D=20
>>>> sama5d3_restart)
>>>> for the condition.
>>> I'm not just that's been an option in our discussion so far.
>>>
>>> Nicolas said that he was agreeing with me, but at the same time sai=
d
>>> the complete opposite of what I was arguing for, so I'm not really
>>> sure what's really on his mind, but the two options that were
>>> discussed were to remove that test, and either:
>>>
>>>    - Use of_device_is_compatible to prevent the loop execution
>>
>> Thank you for explaining, it is clear to me.
>>
>> I'll take this above option. As the of_device_is_compatible() almost=
=20
>> same as of_match_node()/of_match_device(). Except that=20
>> of_device_is_compatible() is more efficient (in this case It calls=20
>> __of_device_is_compatible() directly) than=20
>> of_match_node/of_match_device.
>
> Sorry, after checking the code a little, I'd say use the of_match_nod=
e=20
> instead of of_device_is_compatible() is better. Since After check the=
=20
> of_device_is_compatible() we also need to call of_match_node() again.

Okay, Please forget above reply. As Maxime said test the pointer is not=
=20
good solution here.
So I'll sent out v2 which use of_device_is_compatible().

Best Regards,
Josh Wu

