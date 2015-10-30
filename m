From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/2] drivers:power:twl4030-charger: fix problem with EPROBE_DEFER
Date: Fri, 30 Oct 2015 07:01:02 +0100
Message-ID: <894050DD-47A5-4763-BABA-565AC2BE2E34@goldelico.com>
References: <cover.1446138086.git.hns@goldelico.com> <cfc5db66692e0415c86a08e2a3d37c2b299bf170.1446138086.git.hns@goldelico.com> <5632791A.4020204@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:24942 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758417AbbJ3GBQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 02:01:16 -0400
In-Reply-To: <5632791A.4020204@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, gta04-owner@goldelico.com


Am 29.10.2015 um 20:52 schrieb Nishanth Menon <nm@ti.com>:

> On 10/29/2015 12:01 PM, H. Nikolaus Schaller wrote:
>> devm_usb_get_phy_by_node() may return -EPROBE_DEFER in which
>> case we should also defer probing of the twl4030 charger
>> instead of turing USB charging off (forever).
> 
> s/turing/turning

Thanks for noting this.

> 
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/power/twl4030_charger.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
>> index 423e886..859991f 100644
>> --- a/drivers/power/twl4030_charger.c
>> +++ b/drivers/power/twl4030_charger.c
>> @@ -1059,9 +1059,13 @@ static int twl4030_bci_probe(struct platform_device *pdev)
>> 
>> 		phynode = of_find_compatible_node(bci->dev->of_node->parent,
>> 						  NULL, "ti,twl4030-usb");
>> -		if (phynode)
>> +		if (phynode) {
>> 			bci->transceiver = devm_usb_get_phy_by_node(
>> 				bci->dev, phynode, &bci->usb_nb);
>> +			if (IS_ERR(bci->transceiver) &&
>> +				PTR_ERR(bci->transceiver) == -EPROBE_DEFER)
> I might align this with the IS_ERR

Ok.

> 
>> +				return -EPROBE_DEFER;	/* PHY not ready */
>> +		}
>> 	}
>> 
>> 	/* Enable interrupts now. */
>> 
> 
> Otherwise it looks good to me.

I will update for v2.

BR,
Nikolaus Schaller
igitt