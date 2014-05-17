From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: fix incorrect OPP count handling in of_init_opp_table
Date: Sat, 17 May 2014 10:24:53 +0530
Message-ID: <CAKohpokQk7jf30gLEX_UTaACGi_mPuSdWxeONEir3+U=0x3JPw@mail.gmail.com>
References: <1400237477-24831-1-git-send-email-chander.kashyap@linaro.org>
	<CAKohpomYMcisB-UHp7TOEdxvQ9-1VzyRshQh=P-dQqYOuBz-5g@mail.gmail.com>
	<200048151.0RTJzuPcGp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:48140 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913AbaEQEyx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 17 May 2014 00:54:53 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so3943452oag.34
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2014 21:54:53 -0700 (PDT)
In-Reply-To: <200048151.0RTJzuPcGp@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>

On 17 May 2014 04:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Is this -stable material?  If so, which -stable?

3.7+
