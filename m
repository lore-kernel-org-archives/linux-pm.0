From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: Linux 4.10-rc7
Date: Mon, 6 Feb 2017 07:14:17 +0100
Message-ID: <CA+icZUWP21gVMTSYXq6BGAg7fm7k4t3cz_C77vfCj8XRiVY7cA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36077 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdBFGOS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 01:14:18 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Linus,

here in my environment I hit a pm/runtime problem.
For people seeing this too, [1] has the fix "PM / runtime: Avoid
false-positive warnings from might_sleep_if()".
Just for the records.

Regards,
- Sedat -

[1] http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=a9306a63631493afc75893a4ac405d4e1cbae6aa
