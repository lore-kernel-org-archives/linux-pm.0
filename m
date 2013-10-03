From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/5] PM / OPP: extend DT binding to specify phandle
 of another node for OPP
Date: Thu, 03 Oct 2013 14:05:07 +0100
Message-ID: <524D6B83.5030308@arm.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1380634382-15609-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <524D65A3.5090906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524D65A3.5090906-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Nishanth,

Thanks for reviewing it.

On 03/10/13 13:40, Nishanth Menon wrote:
> On 10/01/2013 08:32 AM, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
[...]
>> +4. Consider an AMP(asymmetric multi-processor) sytem with 2 clusters of
>> +   CPUs. Each cluster has 2 CPUs and all the CPUs within the cluster share
>> +   the clock domain.
>> +
>> +	cpu0: cpu@0 {
>> +		compatible = "arm,cortex-a15";
>> +		reg = <0>;
>> +		operating-points-phandle = <&cluster0_opp>;
>> +	};
>> +
>> +	cpu1: cpu@1 {
>> +		compatible = "arm,cortex-a15";
>> +		reg = <1>;
>> +		operating-points-phandle = <&cluster0_opp>;
>> +	};
>> +
>> +	cpu2: cpu@100 {
>> +		compatible = "arm,cortex-a7";
>> +		reg = <100>;
>> +		operating-points-phandle = <&cluster1_opp>;
>> +	};
>> +
>> +	cpu3: cpu@101 {
>> +		compatible = "arm,cortex-a7";
>> +		reg = <101>;
>> +		operating-points-phandle = <&cluster1_opp>;
>> +	};
>> +
>> +	opps-table {
>> +		cluster0_opp: cluster0_opp {
>> +			operating-points = <
>> +				/* kHz    uV */
>> +				792000  1100000
>> +				396000  950000
>> +				198000  850000
>> +			>;
>> +		};
> Style comment - add an EOL
Ok will fix up.

>> +		cluster1_opp: cluster1_opp {
>> +			operating-points = <
>> +				/* kHz    uV */
>> +				792000  950000
>> +				396000  750000
>> +				198000  450000
>> +			>;
>> +		};
>> +		... /* other device OPP nodes */
>> +	}
>> +
>> +Container Node
>> +--------------
>> +	- It's highly recommended to place all the shared OPPs under single
>> +	  node for consistency and better readability
>> +	- It's quite similar to clocks or pinmux container nodes
>> +	- In the above examples, "opps-table" is the container node
>>
> 
> in short, I love this - thanks for doing this.
> 
> However, could you squash this to patch #2 -> having implementation
> and binding together is better for git log history.
> 
Based on some arguments on the other threads[1] on devicetree list, I thought
having separate patches for binding and driver changes is preferred. Hence the
split, I am OK either way.

Can I add your ACK/Reviewed-by otherwise ?

Regards,
Sudeep

[1] http://www.spinics.net/lists/devicetree/msg04855.html


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
