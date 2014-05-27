From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 4/8] driver/core: cpu: initialize opp table
Date: Tue, 27 May 2014 05:48:27 +0530
Message-ID: <CAKohpokZSw430PWjJfYOPA6KXOJiKFhxRi4BuEf6ouMgUHQ+gw@mail.gmail.com>
References: <cover.1400736536.git.viresh.kumar@linaro.org>
	<6379a5109bf6b4875cc1656b025f9b8186bbb91a.1400736536.git.viresh.kumar@linaro.org>
	<3104462.ta2PpIfF9J@vostro.rjw.lan>
	<CAKohponagSjOVbn-C64yh7=py9kE0m2VGbdquo_1+UzbPFsJ+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:38704 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbaE0AS2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 20:18:28 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so8604668obc.32
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2014 17:18:28 -0700 (PDT)
In-Reply-To: <CAKohponagSjOVbn-C64yh7=py9kE0m2VGbdquo_1+UzbPFsJ+w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Ips Gandhi <inderpal.s@samsung.com>, Nishanth Menon <nm@ti.com>, Chander Kashyap <chander.kashyap@linaro.org>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Shawn Guo <shawn.guo@linaro.org>

On 27 May 2014 05:34, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> We are also using it for cpu->dev_id, but that's not so important. This
> routine wouldn't have existed if you wouldn't have asked for it. It is
> just a wrapper over of_init_opp_table, which also has a dummy
> implementation when its not supported.
>
> So, it might not be worth enough for any other code to use it. :)
> And so I added it here.
>
> Let me know how/where do you want it and I will resend it quickly.

There is another option here, add these print messages in
of_init_opp_table() ? That's the only difference new wrapper has.
