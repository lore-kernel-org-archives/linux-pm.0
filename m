From: Peter Chen <peter.chen@nxp.com>
Subject: RE: [PATCH 4/7] bus: arm-cci: add missing of_node_put after calling
 of_parse_phandle
Date: Mon, 4 Jul 2016 02:48:08 +0000
Message-ID: <HE1PR04MB1450113E1D3A5B0BBF9269C88B380@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
 <1467366121-14120-5-git-send-email-peter.chen@nxp.com>
 <57764626.4060800@arm.com> <20160701103346.GF12735@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160701103346.GF12735@arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

 
>
>On Fri, Jul 01, 2016 at 11:29:58AM +0100, Suzuki K Poulose wrote:
>> On 01/07/16 10:41, Peter Chen wrote:
>> >of_node_put needs to be called when the device node which is got from
>> >of_parse_phandle has finished using.
>> >
>> >Cc: Will Deacon <will.deacon@arm.com>
>> >Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> >Signed-off-by: Peter Chen <peter.chen@nxp.com>
>>
>> Thanks for the fix.
>>
>> >---
>> >  drivers/bus/arm-cci.c | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c index
>> >a49b283..e7b0b8c 100644
>> >--- a/drivers/bus/arm-cci.c
>> >+++ b/drivers/bus/arm-cci.c
>> >@@ -1912,9 +1912,12 @@ static int __cci_ace_get_port(struct device_node *dn,
>int type)
>> >  	cci_portn = of_parse_phandle(dn, "cci-control-port", 0);
>> >  	for (i = 0; i < nb_cci_ports; i++) {
>> >  		ace_match = ports[i].type == type;
>> >-		if (ace_match && cci_portn == ports[i].dn)
>> >+		if (ace_match && cci_portn == ports[i].dn) {
>> >+			of_node_put(cci_portn);
>> >  			return i;
>> >+		}
>> >  	}
>> >+	of_node_put(cci_portn);
>>
>> nit: Could we please do some thing like this ?
>> 		if (ace_match && cci_portn == ports[i].dn)
>> 			break;
>> 	}
>>
>> 	of_node_put(cci_portn);
>> 	return (i < nb_cci_ports) ? i : -ENODEV ;
>>
>> Either way,
>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
>Please route this via arm-soc once you've addressed Suzuki's comment.
>

Hi Will, how to route patch via arm-soc?

Does it mean sending patch by adding arm@kernel.org at To or Cc list?

Peter
