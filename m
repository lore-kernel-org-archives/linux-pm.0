From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cpuidle: add 'failed' statistic
Date: Mon, 10 Mar 2014 22:00:22 -0400
Message-ID: <CAJvTdKmUKS82YxkQio2_bPqXv7kNnyFpHcuvfZ=ExBZrkEg1eA@mail.gmail.com>
References: <1394165650-6927-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:37662 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbaCKCGa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Mar 2014 22:06:30 -0400
In-Reply-To: <1394165650-6927-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Exactly what use-case do you have in mind for this attribute?

"failed" is a strong word.
Some validation guy is going to send me e-mail when it is non-zero...
I don't like that use-case.

But even if re-named, I don't see see how it will be useful.
When I want to see how C-state predictions are doing, I use ftrace,
which can show me the actual expected and actual times, not just a count
of how man times predicted was < actual.
I would rather see some good tracepoints go upstream.

thanks,
Len Brown, Intel Open Source Technology Center
