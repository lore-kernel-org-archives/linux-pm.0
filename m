From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 2/2] add property of "linux,wakeup" for juno.dts
Date: Wed, 16 Sep 2015 09:41:21 +0100
Message-ID: <55F92B31.2060608@arm.com>
References: <1442386021-5113-1-git-send-email-zhaoyang.huang@linaro.org>
 <1442386021-5113-2-git-send-email-zhaoyang.huang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54365 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbbIPIlY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Sep 2015 04:41:24 -0400
In-Reply-To: <1442386021-5113-2-git-send-email-zhaoyang.huang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>



On 16/09/15 07:47, Zhaoyang Huang wrote:
> add property of "linux,wakeup" to let the driver know
> if the device should work as wakeup source
>

I think I made it *pretty clear multiple times by now* that PL011 is
*not a wakeup source* on Juno. I have no idea what you are testing, it
simply can't wakeup the system for suspended state. So I seriously doubt
now what is that you are testing.

So, this patch clearly gets NACK.

Regards,
Sudeep
