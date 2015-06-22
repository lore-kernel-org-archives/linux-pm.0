From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH 3/4] power: Add Qualcomm SMBB driver
Date: Sun, 21 Jun 2015 22:06:16 -0700
Message-ID: <CAJAp7OiB+y_-s0tRJFhPq7MMwvfFiT-h0bqfXQR5GYU9Em4VBQ@mail.gmail.com>
References: <1434662025-9485-1-git-send-email-bjorn.andersson@sonymobile.com>
	<1434662025-9485-4-git-send-email-bjorn.andersson@sonymobile.com>
	<1434733288.2385.173.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35632 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbbFVFGS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 01:06:18 -0400
Received: by lbbwc1 with SMTP id wc1so101726218lbb.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2015 22:06:16 -0700 (PDT)
In-Reply-To: <1434733288.2385.173.camel@x220>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Courtney Cavin <courtney.cavin@sonymobile.com>

On Fri, Jun 19, 2015 at 10:01 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Thu, 2015-06-18 at 14:13 -0700, Bjorn Andersson wrote:
>> --- /dev/null
>> +++ b/drivers/power/qcom_smbb.c
>
>> +MODULE_ALIAS("platform:qcom_smbb");
>
> (The day before yesterday and yesterday I had a, well, lively
> conversation regarding this macro. The interesting bits start at
> https://lkml.org/lkml/2015/6/17/383 .
>
> But in a converstaion today things were rather silent. See
> https://lkml.org/lkml/2015/6/19/68 and the reply, of sorts, in
> https://lkml.org/lkml/2015/6/19/117. Let's see what happens here.)
>
> As I understand it, this alias is only useful if there's a corresponding
> struct platform_device, somewhere. Ie, this alias implies a
> platform_device that will fire of a "MODALIAS=platform:qcom_smbb" uevent
> when it's created. That would be a platform_device using a "qcom_smbb"
> name.
>

As far as I could see the uevents, including MODALIAS, is sent when
the device is added or removed; but the content comes from the device
tree alias, not the MODULE_ALIAS.

The MODULE_ALIAS seems to add an alias to the kernel module
information, which can be used to find this driver during modprobe; in
addition to the actual name of the module.

> If that's correct, then I think this MODULE_ALIAS macro isn't needed
> here, as I couldn't find a platform_device using that name. (But perhaps
> a patch that adds it is pending, somewhere.)
>

I don't see any reason for keeping the MODULE_ALIAS, so I think it
should be removed for v2.

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
