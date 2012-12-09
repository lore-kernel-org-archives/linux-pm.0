From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for Kirkwood
 SoC
Date: Sun, 09 Dec 2012 14:54:58 +0100
Message-ID: <50C49832.7070503@gmail.com>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org> <20121208010708.260209f5@skate> <20121208001152.GA14363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42018 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758570Ab2LINzD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Dec 2012 08:55:03 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so728785bkw.19
        for <linux-pm@vger.kernel.org>; Sun, 09 Dec 2012 05:55:01 -0800 (PST)
In-Reply-To: <20121208001152.GA14363@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, jason@lakedaemon.net, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org

On 12/08/2012 01:11 AM, Russell King - ARM Linux wrote:
> On Sat, Dec 08, 2012 at 01:07:08AM +0100, Thomas Petazzoni wrote:
>> Hello,
>>
>> On Sat,  8 Dec 2012 08:15:50 +0900, Nobuhiro Iwamatsu wrote:
>>> +static const struct of_device_id kirkwood_thermal_id_table[] = {
>>> +	{ .compatible = "marvel,thermal-kirkwood" },
>>
>> marvel ->  marvell
>>
>> Also, I think it should be marvell,kirkwood-thermal, since most other
>> DT compatible strings that we have for Marvell SoCs are
>> marvell,<soc>-<function>.
>>
>> Also, the Device Tree binding documentation is missing (even though it
>> is admittedly going to be a very short documentation).
>
> Is this in any way compatible with the thermal monitoring found on
> Dove (510) stuff?  If so, should it have the SoC prefix in there,
> or should it be "armada-thermal" for the SoC family?

I haven't checked the driver in detail but at least register offsets
and the register-to-temperature function are different for Dove.
This is no big deal and can be handled with compatible strings.

But more important, "kirkwood" includes 88f618x, 88f619x, and 88f6281
that have no thermal diode - at least it is not mentioned in the public
datasheet. So, finally for Nobuhiro's patch I suggest to have two
compatible strings, one for marvell,88f6282-thermal and one for
marvell,88f6282-thermal. Numbering scheme of Marvell SoCs is a mess..

For the driver, the name should be either orion_thermal.c (as we will
reuse it for Dove), or mvebu_thermal.c if there is also a thermal diode
on Armada 370/XP. Using "armada" alone is not a good idea, as it also
includes some pxa-based SoCs - naming scheme of Marvell SoCs is even
more broken than numbering scheme ;)

Sebastian

