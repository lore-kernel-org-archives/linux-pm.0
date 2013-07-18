From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
Date: Thu, 18 Jul 2013 13:21:41 +0530
Message-ID: <CAKohpo=fwxssYQiDoShMak5f=fuOTC4uFaXbW8vb0pE+j7JbUQ@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<6633375.dICiDrHJgK@vostro.rjw.lan>
	<CAKohpokw-bSWEgKvx0jd2QZ0RCz5dORHM9z+VYbTdKoCmKFvsg@mail.gmail.com>
	<2509113.ybUsa2l9tg@vostro.rjw.lan>
	<CAKohpo=1Qov8p3f2xZkfOqaFRNJPJN60KeK4SOXcL9Hw82MkAg@mail.gmail.com>
	<20130717165943.7f06acd9@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:39426 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab3GRHvl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2013 03:51:41 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so3884977oag.27
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2013 00:51:41 -0700 (PDT)
In-Reply-To: <20130717165943.7f06acd9@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lukasz Majewski <l.majewski@majess.pl>, Dirk Brandewie <dirk.brandewie@gmail.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>

On 17 July 2013 20:29, Lukasz Majewski <l.majewski@samsung.com> wrote:
> To be 100% sure - we export boost only when supported (as proposed at v5).

Yes.
