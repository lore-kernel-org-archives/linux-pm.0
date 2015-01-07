From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH RESEND 3/3] Documentation: Add documentation for rt5033
 multifunction device
Date: Tue, 6 Jan 2015 18:02:05 -0600
Message-ID: <CAL_JsqL5UkxkX8hUHvQzFAT8JhGEj-eZLcmxJ4goUMo39_UOEA@mail.gmail.com>
References: <1420523117-6814-1-git-send-email-beomho.seo@samsung.com>
 <1420523117-6814-4-git-send-email-beomho.seo@samsung.com> <CAL_Jsq+Sz_iCkaDWzssA6DFeLX8fQ2hqKut0Gv6i5P706bmvpA@mail.gmail.com>
 <54AC7121.60303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35227 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbbAGAC1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 19:02:27 -0500
In-Reply-To: <54AC7121.60303@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, lee.jone@linaro.org, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, dbaryshkov@gmail.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chanwoo Choi <cw00.choi@samsung.com>, InKi Dae <inki.dae@samsung.com>, sw0312.kim@samsung.com, Lee Jones <lee.jones@linaro.org>

On Tue, Jan 6, 2015 at 5:34 PM, Beomho Seo <beomho.seo@samsung.com> wrote:
> Thank you for review.
>
> On 01/07/2015 01:54 AM, Rob Herring wrote:
>> On Mon, Jan 5, 2015 at 11:45 PM, Beomho Seo <beomho.seo@samsung.com> wrote:
>>> This patch device tree binding documentation for rt5033 multifunction device.

[...]

>>> +               compatible = "i2c-gpio";
>>> +               standard i2c-gpio constraints...
>>> +               fuelgauge {
>>> +                       compatible = "richtek,rt5033-battery".
>>> +               };
>>> +       };
>>
>> I'm a bit confused by this. The fuelgauge is an i2c device hanging off
>> the rt5033 or a 2nd i2c slave on the rt5033?
>>
>
> It is 2nd i2c slave on the rt5033.

Okay, then you should leave out i2c-gpio from the example. The type of
i2c host is not relevant. You could for example have both slaves
attached to the same master. So just this (at the same level as
rt5033@34)

rt5033@35 {
        compatible = "richtek,rt5033-battery";
        interrupt-parent = <&gpx2>;
        interrupts = <3 0>;
        reg = <0x35>;
};

Rob
