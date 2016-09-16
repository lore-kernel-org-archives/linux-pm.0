From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.8-rc7
Date: Fri, 16 Sep 2016 23:06:59 +0200
Message-ID: <CAJZ5v0gFL9uKGwN2yej_GHhuPEgdp+Or=yDhrXmNw4_Omaga3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34205 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbcIPVHB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Sep 2016 17:07:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.8-rc7

to receive a power management fix for v4.8-rc7.

The top-most commit is 778935778c3b88e5152a88765850009006ef2e32

 PM / runtime: Use _rcuidle for runtime suspend tracepoints

and the base is commit 9395452b4aab7bc2475ef8935b4a4fb99d778d70

 Linux 4.8-rc6

More annotations of tracepoints in the runtime PM framework to
prevent RCU from complaining when that code is invoked from the
idle path (Paul McKenney).

Thanks!

---------------

Paul E. McKenney (1):
      PM / runtime: Use _rcuidle for runtime suspend tracepoints

---------------

 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
