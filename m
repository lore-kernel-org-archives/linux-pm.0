From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Make sure CPU is running on a freq from freq-table
Date: Wed, 27 Nov 2013 21:22:01 +0530
Message-ID: <CAKohpomXk34aaG3bKX9AuOcn7ZEXcKrc858jCUhcB2bavcnarQ@mail.gmail.com>
References: <046513da96dfec919a1a41d270c167147d4a9c8d.1385353358.git.viresh.kumar@linaro.org>
	<2309056.KUZA1Fnj0Y@vostro.rjw.lan>
	<CAKohpokjAuUA-o4cJi=N7mO93kTwrmfVqtL-zOHAs6awKoXn1A@mail.gmail.com>
	<4759452.7dXrrSTGCc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:41368 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3K0PwC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2013 10:52:02 -0500
Received: by mail-ob0-f178.google.com with SMTP id uz6so7646240obc.9
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2013 07:52:01 -0800 (PST)
In-Reply-To: <4759452.7dXrrSTGCc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Carlos Hernandez <ceh@ti.com>

On 27 November 2013 19:52, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> And here my question was: Is it safe to continue at all in that case?

Hmm.. Honestly speaking I haven't thought about it earlier. And from
the kind of inputs we got from Nishanth its not safe at all and so we
really need a BUG_ON in this case, instead of WARN_ON.

What do you say?
