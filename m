From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/4] PM / OPP: take RCU lock in dev_pm_opp_get_opp_count
Date: Thu, 18 Dec 2014 07:41:14 +0530
Message-ID: <CAKohpo=ocsVseYj0Ee5rYqMgTDnd9jkvzCFJmaTUFrbiLH1_vw@mail.gmail.com>
References: <1418771379-24369-1-git-send-email-dtor@chromium.org>
	<1418771379-24369-4-git-send-email-dtor@chromium.org>
	<CAKohpok0UieH=Pi4nU2tKqV1_LH+3uzMDr0B8wsN61g1BnG4pg@mail.gmail.com>
	<20141217234713.GT5310@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56839 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbaLRCLP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 21:11:15 -0500
Received: by mail-ob0-f169.google.com with SMTP id vb8so618394obc.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2014 18:11:15 -0800 (PST)
In-Reply-To: <20141217234713.GT5310@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Dmitry Torokhov <dtor@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Stefan Wahren <stefan.wahren@i2se.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Nishanth Menon <nm@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18 December 2014 at 05:17, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> Yep, they can be nested.  Both rcu_read_lock() and rcu_read_unlock()
> are quite fast, as are their friends, so there is almost no performance
> penalty from nesting.  So the decision normally turns on maintainability
> and style.

Thanks again for your kind advice :)
