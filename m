From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] speedstep-smi: enable interrupts when waiting
Date: Wed, 11 Feb 2015 11:29:05 +0800
Message-ID: <CAKohpomf0R9ufRFCe9bwoZLox=sqwbVwgk5Nv5V1CFv58kaK4g@mail.gmail.com>
References: <alpine.LRH.2.02.1502091337090.18363@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:37412 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbBKD3H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Feb 2015 22:29:07 -0500
Received: by mail-oi0-f44.google.com with SMTP id a3so21243814oib.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2015 19:29:05 -0800 (PST)
In-Reply-To: <alpine.LRH.2.02.1502091337090.18363@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 10 February 2015 at 02:38, Mikulas Patocka <mpatocka@redhat.com> wrote:
> On Dell Latitude C600 laptop with Pentium 3 850MHz processor, the
> speedstep-smi driver sometimes loads and sometimes doesn't load with
> "change to state X failed" message.
>
> The hardware sometimes refuses to change frequency and in this case, we
> need to retry later. I found out that we need to enable interrupts while
> waiting. When we enable interrupts, the hardware blockage that prevents
> frequency transition resolves and the transition is possible. With
> disabled interrupts, the blockage doesn't resolve (no matter how long do
> we wait). The exact reasons for this hardware behavior are unknown.
>
> This patch enables interrupts in the function speedstep_set_state that can
> be called with disabled interrupts. However, this function is called with
> disabled interrupts only from speedstep_get_freqs, so it shouldn't cause
> any problem.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com
> Cc: stable@vger.kernel.org
>
> ---
>  drivers/cpufreq/speedstep-lib.c |    3 +++
>  drivers/cpufreq/speedstep-smi.c |   12 ++++++++++++
>  2 files changed, 15 insertions(+)

It looks it was reviewed/Acked long time back, what happened
then ?
