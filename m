From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 4/4] ARM: dts: k2hk-evm: add pm domains for net, qmss
 and knav_dmas
Date: Fri, 26 Sep 2014 19:39:57 +0300
Message-ID: <542596DD.2070003@ti.com>
References: <1411657537-25238-1-git-send-email-grygorii.strashko@ti.com>	<1411657537-25238-5-git-send-email-grygorii.strashko@ti.com> <7hd2aj9vzh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42497 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbaIZQks (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Sep 2014 12:40:48 -0400
In-Reply-To: <7hd2aj9vzh.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: santosh.shilimkar@ti.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, ben.dooks@codethink.co.uk, laurent.pinchart@ideasonboard.com, grant.likely@secretlab.ca, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Kevin,

On 09/26/2014 01:27 AM, Kevin Hilman wrote:
> Grygorii Strashko <grygorii.strashko@ti.com> writes:
> 
>> Add Keystone PM domains nodes for NetCP, NetCPx, QMSS, KNAV-DMA
>> devices.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   arch/arm/boot/dts/k2hk-evm.dts | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
>> index 91371f7..a7b468c 100644
>> --- a/arch/arm/boot/dts/k2hk-evm.dts
>> +++ b/arch/arm/boot/dts/k2hk-evm.dts
>> @@ -58,6 +58,13 @@
>>   				clock-output-names = "refclk-ddr3b";
>>   			};
>>   		};
>> +
>> +		qmss_domain: qmss_pm_controller {
>> +			compatible = "ti,keystone-gpc";
>> +			clocks = <&chipclk13>;
>> +			#power-domain-cells = <0>;
>> +		};
> 
> Hmm, I'm still a bit confused by what you're attempting to do here.
> Unless I'm missing someting, clocks are properties of the device, not
> the pm-domain...
> 
>>   		qmss: qmss@2a40000 {
>>   			compatible = "ti,keystone-navigator-qmss";
>>   			dma-coherent;
>> @@ -65,6 +72,8 @@
>>   			#size-cells = <1>;
>>   			clocks = <&chipclk13>;
>>   			ranges;
>> +			power-domains = <&qmss_domain>;
> 
> ...  Also, each of the pm domains is duplicating the list of clocks from
> the device node, so I'm not sure what this is accomplishing.
> 
> Why not just have a single, more generic power domain that gets the list
> of clocks from the device node.

Ok. I've tried it and seems it will work.

Used GPD callbacks:
		.attach_dev = keystone_pm_domain_attach_dev,
		.detach_dev = keystone_pm_domain_detach_dev,
		.dev_ops = {
			.stop = pm_clk_suspend,
			.start = pm_clk_resume,
		},

Updated DT structure:
		k_domain: k_pm_controller {
			compatible = "ti,keystone-gpc";
			#power-domain-cells = <0>;
		};

		qmss: qmss@2a40000 {
			compatible = "ti,keystone-navigator-qmss";
			dma-coherent;
			#address-cells = <1>;
			#size-cells = <1>;
			clocks = <&chipclk13>;
			ranges;
			power-domains = <&k_domain>;

Thanks for your comments. 
I'll update & re-send.

Regards,
-grygorii





