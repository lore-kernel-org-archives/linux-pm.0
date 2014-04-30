From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: powernow-k8: Fix checkpatch warnings
Date: Wed, 30 Apr 2014 09:34:03 +0530
Message-ID: <CAKohponkTeEqdgqJ6+caQcKd5yoMNhFvkZib1UueqNBCmO=pmA@mail.gmail.com>
References: <5356DB92.1060600@semaphore.gr>
	<2606012.9SjvfKiI5Z@vostro.rjw.lan>
	<5357C5E0.1070207@semaphore.gr>
	<4780344.RfsAca3Qz3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:59548 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaD3EEF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Apr 2014 00:04:05 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so1354996obc.14
        for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2014 21:04:04 -0700 (PDT)
In-Reply-To: <4780344.RfsAca3Qz3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 30 April 2014 04:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> It should be cleaned up generally, so if you have the time and you're willing
> to do such things, please do them.
>
> That said things like lines in excess of 80 characters may stay as they are.

I have tried this sort of stuff earlier, but there is one issue that stands
up again and again. When you update neighboring lines of lines
crossing 80 columns, we do get warnings for lines which aren't actually
updated by us (from checkpatch.pl). So, probably we need to fix
checkpatch then..
