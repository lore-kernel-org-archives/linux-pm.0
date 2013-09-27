From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/2] ARM: zynq: cpuidle: Remove useless compatibility
 string
Date: Fri, 27 Sep 2013 10:51:43 +0200
Message-ID: <c0351789-56de-47f7-bc03-6af126f8e45f@TX2EHSMHS012.ehs.local>
References: <1380269867-18336-1-git-send-email-daniel.lezcano@linaro.org> <31f13d14-2af7-4285-8770-3cc7ef7e7b09@AM1EHSMHS008.ehs.local> <52454342.80706@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:5918 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751548Ab3I0Ivr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 04:51:47 -0400
In-Reply-To: <52454342.80706@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>

On 09/27/2013 10:35 AM, Daniel Lezcano wrote:
> On 09/27/2013 10:19 AM, Michal Simek wrote:
>> On 09/27/2013 10:17 AM, Daniel Lezcano wrote:
>>> All zynq platforms have this compatibility string and there is no any other
>>> clone.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> The patchset is only compile-tested (I don't have the hardware).
> 
> Michal or someone else, if you have the time can you give it a try ?
> 

Soren: Can you please retest it on hw?

Thanks,
Michal


