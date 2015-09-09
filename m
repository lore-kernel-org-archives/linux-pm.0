From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] power: bq24261_charger: Add support for TI BQ24261 charger
Date: Thu, 10 Sep 2015 08:47:46 +0900
Message-ID: <55F0C522.6070705@samsung.com>
References: <1441560187-23611-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPfDu+LxoiQrV+CsqUbEVwYb1Zmk-m9y-L_1JxrB6ouS0g@mail.gmail.com>
 <D854C92F57B1B347B57E531E78D05EAD57904B8D@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:24335 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbIIXru (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 19:47:50 -0400
In-reply-to: <D854C92F57B1B347B57E531E78D05EAD57904B8D@BGSMSX104.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "Tc, Jenny" <jenny.tc@intel.com>, Andreas Dannenberg <dannenberg@ti.com>

On 10.09.2015 03:11, Pallala, Ramakrishna wrote:
>>> +Optional properties:
>>> +- ti,thermal-sensing: boolean, if present thermal regulation will be
>>> +enabled;
>>
>> What is the requirement for thermal-sensing? Can it be enabled always?
>> If yes, then this is not really a hardware property.
> TI BQ24261 has provision to add Battery Pack thermistor but it has no ADC read it.
> So a HW designer would or may not add the thermistor to charger and instead he can
> connect to the Fuel Gauge.

Thanks for explanation, makes sense.

> 
>>> +- ti,enable-user-write: boolean, if present driver will allow the user space
>>> +    to control the charging current and voltage through sysfs;
>>
>> This is not DT property. It does not describe hardware.
> We needed a mechanism to enable the sysfs writes on certain properties.
> If DT is not the place where should it go?

DT is not the place. As I discussed later with Andreas, if you really
need this and if mainline is a place for that then probably this should
be compile option (a Kconfig symbol).

I found one more issue after Andreas comments but I respond in that email.

Best regards,
Krzysztof
