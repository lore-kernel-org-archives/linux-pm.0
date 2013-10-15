From: "Wendy Ng" <wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] ARM: bcm281xx: Add thermal driver to device
 tree.
Date: Tue, 15 Oct 2013 14:10:07 -0700
Message-ID: <525DAF2F.7080009@broadcom.com>
References: <1380321454-16216-1-git-send-email-wendy.ng@broadcom.com>
 <1380321454-16216-4-git-send-email-wendy.ng@broadcom.com>
 <525B1C77.1070809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <525B1C77.1070809-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 10/13/2013 3:19 PM, Eduardo Valentin wrote:
> On 27-09-2013 18:37, Wendy Ng wrote:
>> This patch adds the device tree node for Broadcom bcm281xx SoCs thermal
>> driver.
>>
>> Signed-off-by: Wendy Ng <wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Christian Daudt <csd-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/bcm11351-brt.dts |    4 +++-
>>   arch/arm/boot/dts/bcm11351.dtsi    |    6 ++++++
>>   arch/arm/boot/dts/bcm28155-ap.dts  |    4 ++++
>>   3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
>> index 9d36eb4..0771b6b 100644
>> --- a/arch/arm/boot/dts/bcm11351-brt.dts
>> +++ b/arch/arm/boot/dts/bcm11351-brt.dts
>> @@ -43,5 +43,7 @@
>>   		status = "okay";
>>   	};
>>
>> -
>> +	thermal@34008000 {
>> +		status = "okay";
>> +	};
>>   };
>> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
>> index 05a5aab..aa13353 100644
>> --- a/arch/arm/boot/dts/bcm11351.dtsi
>> +++ b/arch/arm/boot/dts/bcm11351.dtsi
>> @@ -96,4 +96,10 @@
>>   		status = "disabled";
>>   	};
>>
>> +	thermal@34008000 {
>> +		compatible = "brcm,bcm11351-thermal", "brcm,kona-thermal";
>> +		reg = <0x34008000 0x0024>;
>> +		thermal-name = "bcm_kona_therm";
>
> As I mentioned previously, my only concern is this thermal binding,
> which is specific to your driver (BTW, you would need to do
> bcm,thermal-name)
>

Hi Eduardo,

I have a local working copy of the thermal driver that does not use the 
'thermal-name' from this DTS file.  It has been re-based to your working 
version of the new thermal DT binding.

>> +		status = "disabled";
>> +	};
>>   };
>> diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
>> index 96ae67a..a39aa47 100644
>> --- a/arch/arm/boot/dts/bcm28155-ap.dts
>> +++ b/arch/arm/boot/dts/bcm28155-ap.dts
>> @@ -42,4 +42,8 @@
>>   		max-frequency = <48000000>;
>>   		status = "okay";
>>   	};
>> +
>> +	thermal@34008000 {
>> +		status = "okay";
>> +	};
>>   };
>>
>
>


-- 
Best regards,
-Wendy

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
