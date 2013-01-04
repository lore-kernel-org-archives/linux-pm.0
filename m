From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for Orion
 SoC
Date: Fri, 04 Jan 2013 16:35:06 +0100
Message-ID: <50E6F6AA.4000905@lunn.ch>
References: <1355482986-885-1-git-send-email-andrew@lunn.ch> <1355482986-885-2-git-send-email-andrew@lunn.ch> <50E6A378.90503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:36676 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754968Ab3ADPgL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jan 2013 10:36:11 -0500
In-Reply-To: <50E6A378.90503@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, iwamatsu@nigauri.org, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, jgunthorpe@obsidianresearch.com, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>

On 04/01/13 10:40, Eduardo Valentin wrote:
> Hey Andrew,
>
> On 14-12-2012 13:03, Andrew Lunn wrote:
>> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>
>> Some Orion SoC has thermal sensor.
>> This patch adds support for 88F6282 and 88F6283.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> ---
>> .../devicetree/bindings/thermal/orion-thermal.txt | 16 +++
>> drivers/thermal/Kconfig | 7 ++
>> drivers/thermal/Makefile | 1 +
>> drivers/thermal/orion_thermal.c | 133 ++++++++++++++++++++
>> 4 files changed, 157 insertions(+)
>> create mode 100644
>> Documentation/devicetree/bindings/thermal/orion-thermal.txt
>> create mode 100644 drivers/thermal/orion_thermal.c
>>
>> diff --git
>> a/Documentation/devicetree/bindings/thermal/orion-thermal.txt
>> b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
>> new file mode 100644
>> index 0000000..5ce925d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
>> @@ -0,0 +1,16 @@
>> +* Orion Thermal
>> +
>> +This initial version is for Kirkwood 88F8262 & 88F6283 SoCs, however
>> +it is expected the driver will sometime in the future be expanded to
>> +also support Dove, using a different compatibility string.
>> +
>> +Required properties:
>> +- compatible : "marvell,kirkwood-thermal"
>> +- reg : Address range of the thermal registers
>> +
>> +Example:
>> +
>> + thermal@10078 {
>> + compatible = "marvell,kirkwood";
>> + reg = <0x10078 0x4>;
>> + };
>
> How do you differentiate if the SoC has the temperature sensor? On your
> patch description you are very clear saying that this supports only
> 88F8262 & 88F6283 SoCs.

Hi Eduardo

Thanks for the comments. I will address them in the next version.

We differentiate between the different SoCs by DT. Each has its own 
.dtsi file and we will put the node into only those which have the hardware.

Thanks
	Andrew
