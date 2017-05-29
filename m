From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: Re: [PATCH 1/3] regmap: Add OneWire (W1) bus support
Date: Mon, 29 May 2017 19:37:58 +0300
Message-ID: <f4efbd7b-6b65-1344-dc36-8695d1d451e8@rambler.ru>
References: <20170528071120.6604-1-minimumlaw@rambler.ru>
 <20170528071120.6604-2-minimumlaw@rambler.ru>
 <20170529131346.gsauzllpplc2e7vy@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from huan2.mail.rambler.ru ([81.19.78.108]:22490 "EHLO
        huan2.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdE2QiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2017 12:38:00 -0400
In-Reply-To: <20170529131346.gsauzllpplc2e7vy@sirena.org.uk>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

29.05.17 16:13, Mark Brown пишет:

>> +	int ret = -ENODEV;
>> +
>> +	mutex_lock(&sl->master->bus_mutex);
>> +	if (!w1_reset_select_slave(sl)) {
>> +		w1_write_8(sl->master, W1_CMD_READ_DATA);
>> +		w1_write_8(sl->master, reg);
>> +		*val = w1_read_8(sl->master);
>> +		ret = 0;
>> +	}
> I asked you to move the error handling into the else case in these :(
Why do you want to see exactly the construction of if/else?

I already wrote that for me this will worsen the quality and 
understanding of the code. And another point - in fact it is not an 
error handler. This is a completely normal and permissible situation. 
There is no "disconnect" event for this bus, and consequently at any 
arbitrary time the kernel can not be sure that the device is still 
available.

My ret = -ENODEV is exactly about this.

I can see this pattern in other kernel place, like:
drivers/usb/musb/da8xx.c line 374
drivers/usb/musb/davinci.c line 381
drivers/usb/host/xhci-mtk.c line 531
and many other palces.
