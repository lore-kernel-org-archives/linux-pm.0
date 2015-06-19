From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 3/4] power: Add Qualcomm SMBB driver
Date: Fri, 19 Jun 2015 19:01:28 +0200
Message-ID: <1434733288.2385.173.camel@x220>
References: <1434662025-9485-1-git-send-email-bjorn.andersson@sonymobile.com>
	 <1434662025-9485-4-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lb2-smtp-cloud6.xs4all.net ([194.109.24.28]:55501 "EHLO
	lb2-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752303AbbFSRBf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 13:01:35 -0400
In-Reply-To: <1434662025-9485-4-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Courtney Cavin <courtney.cavin@sonymobile.com>

On Thu, 2015-06-18 at 14:13 -0700, Bjorn Andersson wrote:
> --- /dev/null
> +++ b/drivers/power/qcom_smbb.c

> +MODULE_ALIAS("platform:qcom_smbb");

(The day before yesterday and yesterday I had a, well, lively
conversation regarding this macro. The interesting bits start at
https://lkml.org/lkml/2015/6/17/383 . 

But in a converstaion today things were rather silent. See
https://lkml.org/lkml/2015/6/19/68 and the reply, of sorts, in
https://lkml.org/lkml/2015/6/19/117. Let's see what happens here.)

As I understand it, this alias is only useful if there's a corresponding
struct platform_device, somewhere. Ie, this alias implies a
platform_device that will fire of a "MODALIAS=platform:qcom_smbb" uevent
when it's created. That would be a platform_device using a "qcom_smbb"
name.

If that's correct, then I think this MODULE_ALIAS macro isn't needed
here, as I couldn't find a platform_device using that name. (But perhaps
a patch that adds it is pending, somewhere.)

Thanks,


Paul Bolle

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
