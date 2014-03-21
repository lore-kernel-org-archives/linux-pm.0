From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 6/7] Cpuidle: Deal with timer expiring in the past
Date: Fri, 21 Mar 2014 19:10:24 -0400
Message-ID: <CAJvTdKm3FfOgHbEkaDE+N2rwyL6FTnzXHF6Gn2iuxmhz3c9nnA@mail.gmail.com>
References: <1393223377-5744-1-git-send-email-tuukka.tikkanen@linaro.org>
	<1393223377-5744-7-git-send-email-tuukka.tikkanen@linaro.org>
	<CAJvTdKneVk_ToJ=Sv4GnMfn5a0r=ynfL4fRLOoKHsqMrDYr8JA@mail.gmail.com>
	<CAG-99FPk6kX3QO9g3M20SC1fq8VhpVv6iDLsgjZDAUd5KvzCOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:61269 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbaCUXKZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 19:10:25 -0400
In-Reply-To: <CAG-99FPk6kX3QO9g3M20SC1fq8VhpVv6iDLsgjZDAUd5KvzCOQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Tuukka,
I've reproduced this negative on a 48 thread 2-socket Xeon during boot
(seen it only once, so far).

expected_us gets calculated to be -1, which is truthful, since the
next timer return value was about 500ns in the past
and our math truncates.  This, in turn, confuses the heck out of
menu's prediction of the next event to be
over 500 sec in the future.

I suspect more breakage is lurking, so I'll poke some more...

Len Brown, Intel Open Source Technology Center
