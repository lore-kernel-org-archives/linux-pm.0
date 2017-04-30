From: =?UTF-8?B?0JzQuNGF0LDQudC70L7QsiDQkNC70LXQutGB0LXQuSDQkNC90LDRgtC+0Ls=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <minimumlaw@rambler.ru>
Subject: Re: [PATCH 2/2] Add driver for MAX17211/MAX17215 fuel gauge
Date: Sun, 30 Apr 2017 20:32:10 +0300
Message-ID: <77d557e3-3ff3-de60-826c-b98937360d8c@rambler.ru>
References: <20170429143429.5685-1-minimumlaw@rambler.ru>
 <20170429143429.5685-3-minimumlaw@rambler.ru>
 <20170429164053.olynja4kyqpwhfpk@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from huan3.mail.rambler.ru ([81.19.78.109]:18910 "EHLO
        huan3.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427431AbdD3RcN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Apr 2017 13:32:13 -0400
In-Reply-To: <20170429164053.olynja4kyqpwhfpk@earth>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, zbr@ioremap.net

Hi!


>> [...]
>>
>> +	 * FixMe:
>> +	 * Device without no_thermal = true not register (err -22)
>> +	 * Len of platform device name "max17211-battery.X.auto"
>> +	 * more than 20 chars limit in THERMAL_NAME_LENGTH from
>> +	 * include/uapi/linux/thermal.h
>> +	 */
> IIRC we already had problems with small THERMAL_NAME_LENGTH before.
> I suggest to add another patch, that increases THERMAL_NAME_LENGTH
> (don't forget to Cc/To the thermal subsystem people).
May be rename "max17211-battery" to "max17211" and remove no_thermal = 
true? This case thermal zone will work again. In current (mainline) 
kernel all drivers "xxxxxx-battery" (like ds2780-battery or 
ds2760-battery) compiled, but not working (not registered). They can 
start working again without thermal zone by adding no_thermal = true or 
by remove "-battery" from platform device name. Alternative limit on 
THERMAL_NAME_LENGTH may be extended.
>> +	info->bat = power_supply_register(&pdev->dev, &info->bat_desc,
>> +						&psy_cfg);
>> +	if (IS_ERR(info->bat)) {
>> +		dev_err(info->dev, "failed to register battery\n");
>> +		return PTR_ERR(info->bat);
>> +	}
> Please use devm_power_supply_register() and drop the remove
> function.
Khm... probe/remove paired functions. I can use 
devm_power_supply_register in my code. But all other fuel gauge drivers 
use classic probe/remove pair. Which decision will be more correct?
