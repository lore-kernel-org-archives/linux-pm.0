From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 1/2] thermal: generic-adc: Add DT binding for ADC based
 thermal sensor driver
Date: Wed, 6 Apr 2016 22:18:12 +0530
Message-ID: <57053DCC.60708@nvidia.com>
References: <1459936986-2839-1-git-send-email-ldewangan@nvidia.com> <20160406160126.GA638@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16051 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbcDFQ7N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 12:59:13 -0400
In-Reply-To: <20160406160126.GA638@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Eduardo,
Thanks for review.

On Wednesday 06 April 2016 09:31 PM, Eduardo Valentin wrote:
> On Wed, Apr 06, 2016 at 03:33:05PM +0530, Laxman Dewangan wrote:
>> +- step-temperature:	     The temperature steps for the reading ADC
>> +			     value in millicelsius.
> How about when you have a sensor that does not have a nice linear
> stepping correlation ?

Here just temp is stepping but ADC reading is not in linear. So temp vs 
adc value is not linear.
Just making the table that temp vs adc value where temp is in equally 
stepped.

if something is not possible for few steps than that can be intrapolate 
here to get this.

Other way as you said: two dimensional. You mean <temp ADC-value> pair 
for the table?

This is also possible and on this case, we will not need lower/upper and 
step temperature.
Table will provide all the information.

Also, I assume that sensor is negative coefficients. Temp increases->ADC 
read value decreases.

Should we also support positive coefficient relation?

> +			writable;
> Not sure about writable property, where is it described?
It is from my testing, not standard.  I will remove it.
>> +		};
>> +	};
>> +
>> +	cooling-maps {
>> +		map0 {
>> +			trip = <&therm_est_trip>;
>> +			cooling-device = <&dummy_cool_dev THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +			contribution = <100>;
>> +			cdev-type = "therm_est_activ";
>
> Not sure about cdev-type property, where is it described?
 From my testing only. Will remove it.

