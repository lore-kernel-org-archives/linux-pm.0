From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: API for querying the resume cause [2]
Date: Tue, 3 Nov 2015 22:44:12 +0100
Message-ID: <CAJZ5v0hXbv+Z+QMMC7ShWgJwg5A21g_+z=Oa72RwYqNXv+DWnw@mail.gmail.com>
References: <56392743.6080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35811 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932366AbbKCVoN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2015 16:44:13 -0500
Received: by obctp1 with SMTP id tp1so24075845obc.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2015 13:44:12 -0800 (PST)
In-Reply-To: <56392743.6080206@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yan Pashkovsky <yanpaso@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi,

On Tue, Nov 3, 2015 at 10:29 PM, Yan Pashkovsky <yanpaso@gmail.com> wrote:
> Hi everyone!
>
> I was writing you on 21 of August
> (http://marc.info/?t=144007145600001&r=1&w=2)  about API for querying the
> resume cause. I was looking at the releases of linux kernel and discovered
> this:
>
> "Finally, the PM core gets a new mechanism that can be used by
> device drivers to distinguish between suspend-to-RAM (based on
> platform firmware support) and suspend-to-idle (or other variants
> of system suspend the platform firmware is not involved in) and
> possibly optimize their device suspend/resume handling accordingly"
>         http://lkml.iu.edu/hypermail/linux/kernel/1511.0/01164.html
>
> Is it what we were discussing? If yes - that's fine, I'll contact systemd
> team. If no - is this API exists in someone's todo list or smth like this?
> Are there any plans for this?

This is (a small) part of an API that may be used for this purpose
(and is there in someone's to-do list), but it's targeted at
debugging.

Thanks,
Rafael
