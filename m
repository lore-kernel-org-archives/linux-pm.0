From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 07/14] cpufreq: stats: remove cpufreq_stats_update_policy_cpu()
Date: Mon, 5 Jan 2015 09:56:30 +0530
Message-ID: <CAKohpo=_vtzOYFhfPAh34aqeun7r+OYmCyaG7bFUx7_0ccz25Q@mail.gmail.com>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
	<53e8e4e9a40d2759ebdecfe4649f9ecee112a330.1420177186.git.viresh.kumar@linaro.org>
	<2616922.JoeBe3VJ9b@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:61014 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbAEE0b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jan 2015 23:26:31 -0500
Received: by mail-oi0-f51.google.com with SMTP id h136so12809865oig.10
        for <linux-pm@vger.kernel.org>; Sun, 04 Jan 2015 20:26:30 -0800 (PST)
In-Reply-To: <2616922.JoeBe3VJ9b@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 4 January 2015 at 03:55, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Well, "can be" sounds more appropriate than "must be".  It wouldn't hurt to
> leave it as is, after all.

> It's the reverse.  Because the cpu field is not necessary any more, it can
> be dropped *along* *with* cpufreq_stats_update_policy_cpu().
>
> Modifying data structures is more important than dropping a trivial function
> and it should be described this way in the changelog.

> Well, if you wrote it the way I suggested in the previous patch, it would be
> more obvious ...

Ack.
