From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: Re: [PATCH 1/4] Introduce regmap infrastructure over Maxim/Dalas
 OneWire (W1) bus
Date: Fri, 26 May 2017 18:50:25 +0300
Message-ID: <9af21650-51d8-7aa6-445b-9edf634d487a@rambler.ru>
References: <20170525174639.3191-1-minimumlaw@rambler.ru>
 <20170525174639.3191-2-minimumlaw@rambler.ru>
 <20170526102149.l26fzjwg5zxsqq5e@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from huan2.mail.rambler.ru ([81.19.78.108]:7966 "EHLO
        huan2.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764898AbdEZPu2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2017 11:50:28 -0400
In-Reply-To: <20170526102149.l26fzjwg5zxsqq5e@sirena.org.uk>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


> This looks mostly fine, a couple of small things and like I said in
> reply to Greg please use subject lines matching the style for the
> subsystem - this makes it a lot easier for people to identify relevant
> patches.
>
>> +	int ret = -ENODEV;
>> +
>> +
>> +	if (reg > 255)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&sl->master->bus_mutex);
>> +	if (!w1_reset_select_slave(sl)) {
>> +		w1_write_8(sl->master, W1_CMD_READ_DATA);
>> +		w1_write_8(sl->master, reg);
>> +		*val = w1_read_8(sl->master);
>> +		ret = 0;
>> +	}
>> +	mutex_unlock(&sl->master->bus_mutex);
> This is a bit confusing with how -ENODEV is generated - move the
> assignment into the if statement so it doesn't look like we're silently
> ignoring errors unless you look back to the top of the function.
Ok. I set default return value to -ENODEV. W1 (OneWire) Bus periodically 
scan for connected devices. Typical time between scans about 60 sec. 
This period W1 slave device can present in kernel device list, but will 
physically disconnected.

Only w1_reset_select_slave(sl) can say me about device still physically 
accessible. Only on success w1_reset_select_slave return zero. I think 
code, like

if (!w1_reset_select_slave(sl)) {
   [...]
   ret =0;
} else
   ret = -ENODEV;

not good.

>> +static struct regmap_bus regmap_w1_bus_a8_v16 = {
>> +	.reg_read = w1_reg_a8_v16_read,
>> +	.reg_write = w1_reg_a8_v16_write,
>> +};
> It'd be clearer to just have all all these structs at the end of the set
> of functions rather than scattered about randomly.
Ok. I move this structs down in next version of patches.

I hope that the next edition will not contain such a large number of 
registration errors. Sorry for all.
