From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 41/48] powerpc: Register with kernel power-off handler
Date: Tue, 11 Nov 2014 02:42:21 -0800
Message-ID: <5461E80D.4010307@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>	 <1415583785-6980-42-git-send-email-linux@roeck-us.net> <1415691766.9757.1.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43535 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbaKKKmd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Nov 2014 05:42:33 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xo8u8-003RrN-6Q
	for linux-pm@vger.kernel.org; Tue, 11 Nov 2014 10:42:32 +0000
In-Reply-To: <1415691766.9757.1.camel@concordia>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alexander Graf <agraf@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>

On 11/10/2014 11:42 PM, Michael Ellerman wrote:
> On Sun, 2014-11-09 at 17:42 -0800, Guenter Roeck wrote:
>> Register with kernel power-off handler instead of setting pm_power_off
>> directly.
>>
>> If there is an indication that there can be more than one power-off handler,
>> use register_power_off_handler, otherwise use register_power_off_handler_simple
>> to register the power-off handler.
>>
>> If the power-off handler only resets or stops the system, select the fallback
>> priority to indicate that the power-off handler is one of last resort.
>> If the power-off handler powers off the system, select the default priority,
>> unless the power-off handler installation code suggests that there can be
>> more than one power-off handler and the new handler is only installed
>> conditionally. In this case, install the handler with low priority.
>>
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Can you fold in the patch below. I know pm.h is included by device.h, so most
> things will already have it, but I'd rather be explicit.
>
> With that you can add my:
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>

Done.

Thanks,
Guenter


