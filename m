From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v7 2/4] power: reset: add reboot mode driver
Date: Tue, 12 Apr 2016 19:29:27 +0800
Message-ID: <570CDC17.1090901@rock-chips.com>
References: <1459304304-9713-1-git-send-email-andy.yan@rock-chips.com>
 <1459304443-9811-1-git-send-email-andy.yan@rock-chips.com>
 <56FB49B3.2040505@samsung.com> <57045D6B.2080907@rock-chips.com>
 <57045F9D.1000502@samsung.com> <570CBF7F.9090300@rock-chips.com>
 <570CD983.9090202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:59508 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932393AbcDLL36 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 07:29:58 -0400
In-Reply-To: <570CD983.9090202@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, alexandre.belloni@free-electrons.com, f.fainelli@gmail.com, linux@arm.linux.org.uk, dbaryshkov@gmail.com, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, wxt@rock-chips.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, lorenzo.pieralisi@arm.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, moritz.fischer@ettus.com, mbrugger@suse.com, linux-kernel@vger.kernel.org, galak@codeaurora.org, olof@lixom.net, jun.nie@linaro.org, dwmw2@infradead.org

Hi Krzysztof:
     Thanks for you kindly suggestion. I will follow it in next version=
=2E

On 2016=E5=B9=B404=E6=9C=8812=E6=97=A5 19:18, Krzysztof Kozlowski wrote=
:
> On 04/12/2016 11:27 AM, Andy Yan wrote:
>>>>>> +
>>>>>> +static const struct of_device_id syscon_reboot_mode_of_match[] =
=3D {
>>>>>> +    { .compatible =3D "syscon-reboot-mode" },
>>>>>> +    {}
>>>>>> +};
>>>>>> +
>>>>>> +static struct platform_driver syscon_reboot_mode_driver =3D {
>>>>>> +    .probe =3D syscon_reboot_mode_probe,
>>>>> Cleanup needed. What will happen after device unbind? Memory will=
 be
>>>>> released (devm-*()) but reboot notifier won't thus leading to OOP=
S on
>>>>> reboot.
>>>>       From the kernel_restart_prepare function, the reboot notifie=
r will
>>>> be called before device_shutdown. Is there any other case the devi=
ce
>>>> unbind before reboot notifier
>>>> called?
>>> This is a regular module platform driver so unbind can happen any t=
ime
>>> initiated by user, either by unbind command or by module removal. U=
ser
>>> can then re-bind device or not - probably does not matter. Anyway a=
fter
>>> such first unbind, the restart will kaboom instead of do a restart.
>>      I just need to do clean up in remove?
> Yes, you need to clean up everything in remove() callback (in a rever=
sed
> order).
>
> Best regards,
> Krzysztof
>
>
>


