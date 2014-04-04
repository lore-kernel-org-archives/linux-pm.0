From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCHC 0/3] sched/idle : find the idlest cpu with cpuidle info
Date: Fri, 4 Apr 2014 02:29:09 -0400
Message-ID: <CAJvTdKk9AJUfCKGDS1RGDNJwP-Q9gTYswBEHHji6L6Lq3yd8JA@mail.gmail.com>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:42638 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbaDDG3K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Apr 2014 02:29:10 -0400
In-Reply-To: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, nicolas.pitre@linaro.org, Linux PM list <linux-pm@vger.kernel.org>, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com

Hi Daniel,

Interesting idea.

The benefit of this patch is to reduce power.
Have you been able to measure a power reduction, via power meter, or
via built-in RAPL power meter?
(turbostat will show RAPL watts, or if you have constant quantity of
work, use turbostat -J)

thanks,
-Len
