From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Fri, 21 Aug 2015 00:29:23 +0200
Message-ID: <55D654C3.4040808@linaro.org>
References: <1440057962-13373-1-git-send-email-s.hauer@pengutronix.de> <1440057962-13373-3-git-send-email-s.hauer@pengutronix.de> <20150820222039.GA6708@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35188 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbbHTW3Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2015 18:29:25 -0400
Received: by pacdd16 with SMTP id dd16so28927230pac.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2015 15:29:25 -0700 (PDT)
In-Reply-To: <20150820222039.GA6708@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>

On 08/21/2015 12:20 AM, Eduardo Valentin wrote:
> On Thu, Aug 20, 2015 at 10:06:01AM +0200, Sascha Hauer wrote:
>> This adds support for the Mediatek thermal controller found on MT817=
3
>> and likely other SoCs.
>> The controller is a bit special. It does not have its own ADC, inste=
ad
>> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
>> we need the physical address of the AUXADC. Also it controls a mux
>> using AHB bus accesses, so we need the APMIXEDSYS physical address a=
swell.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---

[ ... ]

>> +	/*
>> +	 * These calibration values should finally be provided by the
>> +	 * firmware or fuses. For now use default values.
>> +	 */
>> +	mt->calib_slope =3D -123;
>> +	mt->calib_offset =3D 465124;
>
> Would it make sense to use the coefficients device tree property to
> describe the sensor slope and offset?

Trim the mail when possible please.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

