From: Brian Norris <briannorris@chromium.org>
Subject: [BUG] genpd: domains can suspend asynchronously
Date: Tue, 22 Nov 2016 15:07:25 -0800
Message-ID: <20161122230724.GA86250@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36663 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933605AbcKVXPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 18:15:18 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so6198442pfz.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2016 15:14:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

I reported this previously in the midst of another tangentially-related
thread, so it could easily have gotten lost. I thought I'd repeat it
here.

---

I noticed the genpd code has comments like this scattered all over:

 * This function is only called in "noirq" and "syscore" stages of system power
 * transitions, so it need not acquire locks (all of the "noirq" callbacks are
 * executed sequentially, so it is guaranteed that it will never run twice in
 * parallel).

Isn't that no longer true, now that noirq suspend can be asynchronous?
Maybe we should grep for the phrase "need not acquire locks" throughout
the kernel, in order to find low-hanging fruit for race conditions :)

---

Anyway, I was considering hacking my way through the subsystem here
sometime, but there's no guarantee. And in case someone else wanted to
fix this up, I figured I'd least put the report out there.

NB: I noticed there are more drivers enabling asynchronous suspend these
days. Some USB, SDIO, and MMC host controllers seem ripe for triggering
bugs here.

Brian
