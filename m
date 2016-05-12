From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC] Should we add Android's Interactive governor into mainline now?
Date: Thu, 12 May 2016 07:34:01 +0530
Message-ID: <CAKohponvfRR=nDPcVWpW0L1JZO9+7hgLL7YrWwyJXkL8BtJNpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:33166 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbcELCED (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2016 22:04:03 -0400
Received: by mail-io0-f170.google.com with SMTP id f89so77690029ioi.0
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2016 19:04:02 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Ingo Molnar <mingo@kernel.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

Hi Rafael and others,

Since we have moved away from the background timers to scheduler
callbacks, should we consider merging the Interactive governor into
mainline ?

It was rejected earlier for few reasons, one of which was that we
didn't wanted to add on any new governors before the background
timers hack is removed and inputs received from scheduler.

I can try putting some effort to do that, but wanted to check what
others feel about it first.

Its getting used for mobile phones using Android for a very long
time now.

--
viresh
