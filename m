From: vichy <vichy.kuo@gmail.com>
Subject: Re: Auto suspend not working on usb hid devices
Date: Tue, 13 Jan 2015 20:11:19 +0800
Message-ID: <CAOVJa8H9+tDB-arQ8UFJzkOr7W3uhkStSHCxHo1UV+QegqkuZw@mail.gmail.com>
References: <CAOVJa8H1JsarfphiWmTEw8MsJUxDcYi=c5GPJzvbvhziAiDcXA@mail.gmail.com>
	<Pine.LNX.4.44L0.1501121011580.1707-100000@iolanthe.rowland.org>
	<CAOVJa8GkYnT3MV-jgLhoagUL1N3GhTGooho=pbVr7LcUUWXwvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34381 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbbAMMLU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jan 2015 07:11:20 -0500
Received: by mail-ob0-f174.google.com with SMTP id uz6so2129932obc.5
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2015 04:11:19 -0800 (PST)
In-Reply-To: <CAOVJa8GkYnT3MV-jgLhoagUL1N3GhTGooho=pbVr7LcUUWXwvQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org

hi alan:


>> The pm_runtime_put_async_autosuspend() call decrements runtime_usage
>> back to 1.
> I purposely dump runtime_usage after calling
> pm_runtime_put_async_autosuspend(), but the value is still 2.
> I found the value increase/decrease like below:
> pm_runtime_get_noresume => 1
> usb_disable_autosuspend => 2
> usb_probe_device
>     -> usb_autoresume_device => 3
> usb_set_configuration
>     ->usb_autoresume_device =>4
> usb_set_configuration
>     ->usb_autosuspend_device =>3
> pm_runtime_put_sync_autosuspend => 2
>
> so even after calling pm_runtime_put_async_autosuspend() at end fo
> usb_new_device()
> the runtime_usage will not be back to 1

is there any rule for us to determine where we add those
usb_autoresume_device/usb_autosuspend_device in usb driver?

Sincerely appreciate your help,
