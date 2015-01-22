From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power subsystem
Date: Thu, 22 Jan 2015 10:48:12 +0100
Message-ID: <54C0C75C.30603@i2se.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com> <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com> <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com> <54C0C4DD.2040302@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:57671 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbAVJs5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jan 2015 04:48:57 -0500
In-Reply-To: <54C0C4DD.2040302@armadeus.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?windows-1252?Q?S=E9bastien_SZYMANSKI?= <sebastien.szymanski@armadeus.com>, Sebastian Reichel <sre@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello,

Am 22.01.2015 um 10:37 schrieb S=E9bastien SZYMANSKI:
> Hello,
>
> On 01/22/2015 09:08 AM, Stefan Wahren wrote:
>> In the meantime i made some bugfixes on these patches. Now i think i=
t
>> would be better to integrate the on-chip regulator driver into the p=
atch
>> series. That would clarify the function of the power driver.
>>
> I was about to resend this series with a poweroff driver for the imx2=
8
> SoCs.

sounds great.

> Should I wait this series get merged?

Yes, please. In the meantime you can use my repo at github (based on
pm+acpi-3.19-rc4):

https://github.com/lategoodbye/linux-mxs-power

>
> I thought adding a poweroff child node like this:
>
> power: power@80044000 {
> 	...
> 	poweroff: poweroff@80044100 {
> 		compatible =3D "fsl,imx28-poweroff";
> 		reg =3D <0x80044100 0x10>;
> 	};
> 	...
> };

Just a note to your driver it would be nice if it's handles i.MX23 and
i.MX28.

> [...]

Regards Stefan
