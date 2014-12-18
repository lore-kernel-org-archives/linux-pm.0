From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/4] PM / OPP: take RCU lock in dev_pm_opp_get_opp_count
Date: Thu, 18 Dec 2014 07:41:59 +0530
Message-ID: <CAKohpok4tk+P=ku-NjKiaW_VNmA-CwOyE9O3SoWHFhzNEx=VTw@mail.gmail.com>
References: <1418771379-24369-1-git-send-email-dtor@chromium.org>
	<1418771379-24369-4-git-send-email-dtor@chromium.org>
	<CAKohpok0UieH=Pi4nU2tKqV1_LH+3uzMDr0B8wsN61g1BnG4pg@mail.gmail.com>
	<3741028.CtOSUWyiaT@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:55552 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbaLRCL7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 21:11:59 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so542013obc.11
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2014 18:11:59 -0800 (PST)
In-Reply-To: <3741028.CtOSUWyiaT@dtor-glaptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Stefan Wahren <stefan.wahren@i2se.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Nishanth Menon <nm@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 17 December 2014 at 22:58, Dmitry Torokhov <dtor@chromium.org> wrote:
> FWIW the change is a stop-gap; I hope we'll get away from using
> dev_pm_opp_get_opp_count() in cpufreq drivers and then we can revert the
> change. I just did not want to touch cpufreq drivers unless necessary.

Yeah, all good now. No more questions :)
