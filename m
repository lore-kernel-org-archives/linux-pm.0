From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH v2 0/3] power: rt5033: Add Richtek RT533 drivers
Date: Mon, 12 Jan 2015 19:51:22 +0900
Message-ID: <54B3A72A.8020700@samsung.com>
References: <1420793114-20586-1-git-send-email-beomho.seo@samsung.com>
 <1421059225.22660.33.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59216 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbbALKvZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 05:51:25 -0500
In-reply-to: <1421059225.22660.33.camel@x220>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sre@kernel.org, lee.jone@linaro.org, broonie@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, cw00.choi@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com, beomho.seo@samsung.com

Thank you reply.

On 01/12/2015 07:40 PM, Paul Bolle wrote:
> Beomho,
> 
> On Fri, 2015-01-09 at 17:45 +0900, Beomho Seo wrote:
>> This patchset adds driver for Richtek rt5033 chip The chip contains
>> switching charge mode Li-Ion/Li-Polymer battery charger, fuelgauge.
>> Additionally, This includes document for device tree of RT5033 device.
>>
>> RT5033 core driver is applied by Lee Jones.
>> RT5033 regulator driver have been merged by Mark Brown. commit is below,
>>
>> commit b1917578fd5d8efa67afa05a0d6d7e323f2802da
>>
>> Changes in v2:
>> - Revise binding documentation..
>>  
>> Beomho Seo (3):
>>   power: rt5033_battery: Add RT5033 Fuel gauge device driver
>>   power: rt5033_charger: Add RT5033 charger device driver
>>   Documentation: Add documentation for rt5033 multifunction device
>>
>>  Documentation/devicetree/bindings/mfd/rt5033.txt   |  101 ++++
>>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>>  drivers/power/Kconfig                              |   16 +
>>  drivers/power/Makefile                             |    2 +
>>  drivers/power/rt5033_battery.c                     |  177 +++++++
>>  drivers/power/rt5033_charger.c                     |  485 ++++++++++++++++++++
>>  6 files changed, 782 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/rt5033.txt
>>  create mode 100644 drivers/power/rt5033_battery.c
>>  create mode 100644 drivers/power/rt5033_charger.c
> 
> This series adds two drivers that depend on MFD_RT5033. But there's
> currently no Kconfig symbol MFD_RT5033.
> 
> The regulator driver mentioned above is another driver that depends on
> MFD_RT5033. It was included first in next-20141117. It is also included
> in mainline since v3.19-rc1. That regulator driver has never been
> buildable, even if one bypasses its dependency on MFD_RT5033. That is
> because it includes two headers that are not yet part of the tree
> (linux/mfd/rt5033.h and linux/mfd/rt5033-private.h).
> 
> When is the Kconfig symbol MFD_RT5033 expected to be included in the
> tree?
> 
> 
> Paul Bolle
> 
> 

MFD_RT5033 have been applied in 09 Dec 2014.
http://marc.info/?l=linux-pm&m=141822463218774&w=2
According to the mail, That is expected to include next version.

Best regards,
Beomho Seo
