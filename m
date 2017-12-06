From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/6] dt-bindings: marvell: Add documentation for the North Bridge PM on Armada 37xx
Date: Wed, 06 Dec 2017 12:51:07 +0100
Message-ID: <87zi6wt6qc.fsf@free-electrons.com>
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
        <20171201112508.14121-2-gregory.clement@free-electrons.com>
        <20171204214706.4sbjgxme3ftmf3l3@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171204214706.4sbjgxme3ftmf3l3@rob-hp-laptop> (Rob Herring's
        message of "Mon, 4 Dec 2017 15:47:06 -0600")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hua Jing <jinghua-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Neta Zur Hershkovits <neta-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Evan Wang <xswang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Rob,
 
 On lun., déc. 04 2017, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Fri, Dec 01, 2017 at 12:25:03PM +0100, Gregory CLEMENT wrote:
>> Extend the documentation of the Armada 37xx SoC with the the North
>> Bridge Power Management component.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>  .../devicetree/bindings/arm/marvell/armada-37xx.txt   | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> index 51336e5fc761..7ad9830d9177 100644
>> --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> @@ -14,3 +14,22 @@ following property before the previous one:
>>  Example:
>>  
>>  compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
>> +
>> +
>> +Power management
>> +----------------
>> +
>> +For power management (particularly DVFS and AVS), the North Bridge
>> +Power Management component is needed:
>> +
>> +Required properties:
>> +- compatible     : should contain "marvell,armada-3700-nb-pm", "syscon";
>> +- reg            : the register start and length for the North Bridge
>> +		    Power Management
>> +
>> +Example:
>> +
>> +nb_pm: nb_pm@14000 {
>
> Don't use underscore in node or property names. "syscon" is a better 
> choice here.

OK I will change this.

Thanks,

Gregory

>
>> +	compatible = "marvell,armada-3700-nb-pm", "syscon";
>> +	reg = <0x14000 0x60>;
>> +}
>> -- 
>> 2.15.0
>> 

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
