From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] thermal: Bind cooling devices with the correct arguments
Date: Wed, 18 Jun 2014 15:17:48 -0700
Message-ID: <53A2100C.6080701@codeaurora.org>
References: <1401789598-14967-1-git-send-email-punit.agrawal@arm.com> <9hh61jzsuq1.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:56213 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbaFRWRu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jun 2014 18:17:50 -0400
In-Reply-To: <9hh61jzsuq1.fsf@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

On 06/17/14 03:20, Punit Agrawal wrote:
> Ping?
>
> Punit Agrawal <punit.agrawal@arm.com> writes:
>
>> When binding cooling devices to thermal zones created from the device
>> tree the minimum and maximum cooling states are in the wrong order
>> leading to failure to bind.
>>
>> Fix the order of cooling states in the call to
>> thermal_zone_bind_cooling_device to fix this.
>>
>> Cc:Zhang Rui <rui.zhang@intel.com>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

Ah I ran into the same problem while testing out some thermal DT stuff.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

