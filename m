From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: Fwd: [PATCH v2 0/8] PM / devfreq: Add NoCP devfreq-event and
 support busfreq on exyno5422-odroidxu3
Date: Mon, 02 May 2016 08:24:16 +0200
Message-ID: <5726F290.8050808@samsung.com>
References: <1894783822.297231462168123817.JavaMail.weblogic@ep2mlwas04a>
 <5726EBD7.30403@samsung.com> <5726EE55.7050204@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35424 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbcEBGYW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 02:24:22 -0400
In-reply-to: <5726EE55.7050204@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, =?UTF-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "m.reichl@fivetechno.de" <m.reichl@fivetechno.de>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.k

On 05/02/2016 08:06 AM, Krzysztof Kozlowski wrote:
> On 05/02/2016 07:55 AM, Krzysztof Kozlowski wrote:
>> On 05/02/2016 07:48 AM, MyungJoo Ham wrote:
>>> Sender : =EC=B5=9C=EC=B0=AC=EC=9A=B0<cw00.choi@samsung.com> S5(=EC=B1=
=85=EC=9E=84)/Change Agent/Tizen Platform Lab(S/W=EC=84=BC=ED=84=B0)/=EC=
=82=BC=EC=84=B1=EC=A0=84=EC=9E=90
>>> Date : 2016-04-15 15:32 (GMT+09:00)
>>>>
>>>> This patchset support the AMBA bus frequency scaling on Exynos5422=
-based
>>>> Odroid-XU3 board. But, this series only support the bus frequency =
scaling
>>>> for INT (Internal) block using VDD_INT power line.
>>>
>>> Along with Devfreq/Passive patchset, the patchset is merged in
>>> devfreq for-4.7 tree.
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/log/?h=
=3Dfor-4.7
>>>
>>> @Chanwoo: If there are commits to be merged by a tree other than Li=
nux/PM,
>>> please let me know. I'll send out pull-request soon.

=2E.. and now I noticed that you also applied clock patches. Please don=
't.
They are for some time in clk tree. Sylwester prepared a tag for that,
if you need one.

Best regards,
Krzysztof

