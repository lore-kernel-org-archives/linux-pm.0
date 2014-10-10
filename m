From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 19:28:13 +0530
Message-ID: <CAKohpokpQm=6GCz0QxKsjTu1LLzWTx8MVADNj9qGcubqd5wNfw@mail.gmail.com>
References: <5437E53F.2000209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:54991 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240AbaJJN6O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 09:58:14 -0400
Received: by mail-oi0-f49.google.com with SMTP id a3so6539857oib.36
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2014 06:58:13 -0700 (PDT)
In-Reply-To: <5437E53F.2000209@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

On 10 October 2014 19:25, Prarit Bhargava <prarit@redhat.com> wrote:
>  [<ffffffff81570c27>] ? __cpufreq_governor+0x57/0x230
>  [<ffffffff810e1a1d>] ? trace_hardirqs_on+0xd/0x10
>  [<ffffffff81574f27>] od_cpufreq_governor_dbs+0x17/0x20
>  [<ffffffff81570c62>] __cpufreq_governor+0x92/0x230

Looks similar to Robert's crash. Can you also provide which line
crashed it for you with objdump ?
