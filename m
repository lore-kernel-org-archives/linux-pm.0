From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [RFC v2 7/7] ARM: dts: exynos4x12: add suspend OPP for DMC and
 leftbus for Prime
Date: Mon, 19 Dec 2016 15:28:18 +0100
Message-ID: <5857EE82.90403@math.uni-bielefeld.de>
References: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
 <1482113787-28422-8-git-send-email-tjakobi@math.uni-bielefeld.de>
 <3433933.B7FFrWlFIV@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:45508 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755131AbcLSO3W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 09:29:22 -0500
In-Reply-To: <3433933.B7FFrWlFIV@amdc3058>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com

Hi Bartlomiej,


Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Monday, December 19, 2016 03:16:27 AM Tobias Jakobi wrote:
>> Both DMC and leftbus adjust regulator voltages (MIF and INT
>> respectively), which have to be in a safe range to allow the
>> BL0 to operate correctly.
>>
>> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> ---
>>  arch/arm/boot/dts/exynos4412-prime.dtsi | 2 ++
> 
> Could you please post patch(es) adding this file?  I'm planning to fix
> OPPs for Exynos4412-Prime and don't wont to duplicate efforts.
I can do it, but I rather not. My patches are based on the vendor kernel
by Hardkernel. But I'm not affiliated with with either Hardkernel nor
Samsung, so I have no access to the reference manual and no idea if the
frequencies and voltages are actually correct. I don't want to sign off
something which I can't verify to be correct...



> Also please remember to mention in the cover letter the tree that your
> patchset is based on (if it is different than the mainline).
I usually base patches on current torvalds/master, but I didn't bother
with this series since it's RFC and very much WIP. I don't think even
the devfreq bits cleanly apply. Anyway, I'm doing it properly once this
is out of RFC.



With best wishes,
Tobias


> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-prime.dtsi b/arch/arm/boot/dts/exynos4412-prime.dtsi
>> index 97d1b9c..18e411f 100644
>> --- a/arch/arm/boot/dts/exynos4412-prime.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412-prime.dtsi
>> @@ -123,6 +123,7 @@
>>  		opp@400000000 {
>>  			opp-hz = /bits/ 64 <400000000>;
>>  			opp-microvolt = <1100000>;
>> +			opp-suspend;
>>  		};
>>  	};
>>  
>> @@ -145,6 +146,7 @@
>>  		opp@200000000 {
>>  			opp-hz = /bits/ 64 <200000000>;
>>  			opp-microvolt = <1150000>;
>> +			opp-suspend;
>>  		};
>>  	};
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

