From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] PM / OPP: Implement opp_remove and free_opp_table functions
Date: Wed, 21 May 2014 13:43:59 +0530
Message-ID: <CAKohpokqGxEn4ogLDk69XrCdPEtAo9ywYTd1MS=12G-pY6GaVg@mail.gmail.com>
References: <1400231366-1221-1-git-send-email-inderpal.s@samsung.com>
	<1400651502-23703-1-git-send-email-inderpal.s@samsung.com>
	<CAKohpo=UgVoBL2xNBwe_AoqtCOYj4Rcc=vHh2kb=64UHLjjiAw@mail.gmail.com>
	<CAOqmu80zZ3u+XUUaDedpNoziaSVZ_Qbc38yhy4aYVSF1riSfHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:52408 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbaEUIOA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 04:14:00 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so1882702oag.27
        for <linux-pm@vger.kernel.org>; Wed, 21 May 2014 01:13:59 -0700 (PDT)
In-Reply-To: <CAOqmu80zZ3u+XUUaDedpNoziaSVZ_Qbc38yhy4aYVSF1riSfHQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Inderpal Singh <inderpal.s@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>

On 21 May 2014 13:36, Inderpal Singh <inderpal.s@samsung.com> wrote:
> Its being used in opp_remove_and_free function to free dev_opp with kfree_rcu.

Wasn't aware of how kfree_rcu works :(
