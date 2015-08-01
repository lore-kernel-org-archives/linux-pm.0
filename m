From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 1/4] ARM: dts: Add binding documentation for AXP20x
 pmic usb power supply
Date: Sat, 1 Aug 2015 09:43:24 +0200
Message-ID: <55BC789C.4020205@redhat.com>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <20150724145928.GG27569@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36054 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbbHAHn2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 1 Aug 2015 03:43:28 -0400
In-Reply-To: <20150724145928.GG27569@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

Hi,

On 24-07-15 16:59, Sebastian Reichel wrote:
> Hi,
>
> On Fri, Jun 26, 2015 at 12:59:14PM +0200, Hans de Goede wrote:
>> Add binding documentation for the usb power supply part of the AXP20x pmic.
>> [...]
>> +Example:
>> +
>> [...]
>> +
>> +	usb_power_supply: usb_power_supply {
>                        ^^^^^^^^^^^^^^^^
>                        use usb-power-supply here.

Ok, fixed for the upcoming v4 of the power-supply part of this patch set.

Regards,

Hans
