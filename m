From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v2 2/4] ARM: dts: pxa: add pxa25x cpu operating points
Date: Tue, 18 Oct 2016 17:30:11 +0200
Message-ID: <87vawp4qv0.fsf@belgarion.home>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
        <1476561450-28407-3-git-send-email-robert.jarzmik@free.fr>
        <20161018113944.GC11471@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161018113944.GC11471@vireshk-i7> (Viresh Kumar's message of
        "Tue, 18 Oct 2016 17:09:44 +0530")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On 15-10-16, 21:57, Robert Jarzmik wrote:
>> Add the relevant data taken from the PXA 25x Electrical, Mechanical, and
>> Thermal Specfication. This will be input data for cpufreq-dt driver.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/pxa25x.dtsi | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
>> index 0d1e012178c4..16b4e8bad4a5 100644
>> --- a/arch/arm/boot/dts/pxa25x.dtsi
>> +++ b/arch/arm/boot/dts/pxa25x.dtsi
>> @@ -89,4 +89,29 @@
>>  		clocks = <&clktimer>;
>>  		status = "okay";
>>  	};
>> +
>> +	pxa250_opp_table: opp_table0 {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp@99500 {
>
> We have been keeping the values in ^^^ same as the values present
> below. Any specific reason for making it different here ?
No, that's a good comment, I'll change that.

I wrote this incrementaly, first the node, then the opp-hz. Then I realized that
the source crystal, at 3.8684 MHz didn't provide a round 99.5 MHz core clock,
but a 99.5328 MHz clock.

Anyway, I'll change that ... let's say into opp@99533 in this case ?

-- 
Robert
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
