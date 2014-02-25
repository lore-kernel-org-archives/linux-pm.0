From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] PM / devfreq: Fix out of bounds access of transition
 table array
Date: Tue, 25 Feb 2014 13:13:56 -0800
Message-ID: <530D0794.2080405@codeaurora.org>
References: <1393226100-18428-1-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:46289 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbaBYVN5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2014 16:13:57 -0500
In-Reply-To: <1393226100-18428-1-git-send-email-skannan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02/23/2014 11:15 PM, Saravana Kannan wrote:
> The previous_freq value for a device could be an invalid frequency that
> results in a error value being returned from devfreq_get_freq_level().
> Check for an error value before using that to index into the transition
> table.
>
> Not doing this check will result in memory corruption when previous_freq is
> not a valid frequency.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>

MyungJoo/Kyungmin,

Would either of you have some time to respond to this?

Thanks,
Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
