From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: discard duplicate OPP additions
Date: Thu, 15 May 2014 11:31:58 +0530
Message-ID: <CAKohpo=mYH1f69B+dHwQR71Qmpi7a07rWhQ=up-9zriY9hOFng@mail.gmail.com>
References: <1399966890-22926-1-git-send-email-k.chander@samsung.com>
	<20140514150255.GA8330@amd.pavel.ucw.cz>
	<CAKohpo=MFxUHL22TxXPk4B=JX9AD3RGdgXPPGK9sD3GD6AEV+g@mail.gmail.com>
	<CAOqmu80j2q6hQLThVt60QkjqcZTXwJ6ddwDLvqBEW1ejrVh_hw@mail.gmail.com>
	<CAKohponWM+RxgK-50BXH-gk3-bX2no7NojT5-6ZRWJAtSizO7A@mail.gmail.com>
	<CAOqmu81C7A-bMQY3p5fsvk-4Y=S1yGZHw_Q=RbxCKxwR9fFz-w@mail.gmail.com>
	<CAKohpon+YbHx_P0oxkT5vSKVn30aZBddykgLLfyg5N3gPEXe6w@mail.gmail.com>
	<CAOqmu81sUqCTw_x2HZAjfQhzdH6aRMOPAy+i_HeScp2q8zTzuQ@mail.gmail.com>
	<CAKohponTH9X6AUX_0TJbRw0bUw5WQaE6oeDpGW9avTLifLGBCQ@mail.gmail.com>
	<CAOqmu83ptKYHECdtLgEJLxbWa-VjxjKfw4dQo2gqQJP4doS_FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:34669 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaEOGB7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 May 2014 02:01:59 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so696414oac.36
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2014 23:01:59 -0700 (PDT)
In-Reply-To: <CAOqmu83ptKYHECdtLgEJLxbWa-VjxjKfw4dQo2gqQJP4doS_FQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Inderpal Singh <inderpal.s@samsung.com>
Cc: Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, "[Chander Kashyap" <chander.kashyap@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>

On 15 May 2014 11:16, Inderpal Singh <inderpal.s@samsung.com> wrote:
> I think I did not make myself clear.

Probably I was the one who got confused :)

> Devfreq will have its own opp table associated with its own device. It
> does not uses the opp table of cpus.
> Hence there may be need to free the table if driver (at least devfreq)
> getting un-registered.

We may have an unregister routine routine, I am not arguing about that.
But we don't need to call that for CPU's opp, that's it.. For devices it might
make sense to free memory.
