From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 4/4] power: Add an axp20x-usb-power driver
Date: Wed, 12 Aug 2015 14:22:00 +0200
Message-ID: <55CB3A68.5080001@redhat.com>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <1435316357-26606-4-git-send-email-hdegoede@redhat.com>
 <20150724151020.GH27569@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36756 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbbHLMWF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Aug 2015 08:22:05 -0400
In-Reply-To: <20150724151020.GH27569@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>

Hi Sebastian,

On 24-07-15 17:10, Sebastian Reichel wrote:
> Hi,
>
> On Fri, Jun 26, 2015 at 12:59:17PM +0200, Hans de Goede wrote:
>> This adds a driver for the usb power_supply bits of the axp20x PMICs=
=2E
>>
>> I initially started writing my own driver, before coming aware of
>> Bruno Pr=E9mont's excellent earlier RFC with a driver for this.
>>
>> My driver was lacking CURRENT_MAX and VOLTAGE_MIN support Bruno's
>> drvier has, so I've copied the code for those from his driver.
>>
>> Note that the AC-power-supply and battery charger bits will need sep=
arate
>> drivers. Each one needs its own devictree child-node so that other
>> devicetree nodes can reference the right power-supply, and thus each=
 one
>> will get its own mfd-cell / platform_device and platform-driver.
>
> Once the other comments have been taken care of, the driver looks ok
> to me.

I send out a v4 taking care of the other comments a while back, any
news on this? Anything I need todo from my side to get things moving?

Thanks & Regards,

Hans
