From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 3/4] irq: Allow multiple clients to register for irq affinity notification
Date: Mon, 18 Aug 2014 17:04:22 -0700
Message-ID: <7hzjf1uyyh.fsf@paris.lan>
References: <1407945689-18494-1-git-send-email-lina.iyer@linaro.org>
	<1407945689-18494-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:44303 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbaHSAEZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Aug 2014 20:04:25 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so8531914pdj.14
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2014 17:04:24 -0700 (PDT)
In-Reply-To: <1407945689-18494-4-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Wed, 13 Aug 2014 10:01:28 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, tglx@linutronix.de, rjw@rjwysocki.net

Lina Iyer <lina.iyer@linaro.org> writes:

> The current implementation allows only a single notification callback
> whenever the IRQ's SMP affinity is changed. Adding a second notification
> punts the existing notifier function out of registration.
>
> Add a list of notifiers, allowing multiple clients to register for irq
> affinity notifications.

nit: the changelog describes "what", but doesn't answer "why?"  You
address it a bit in the cover letter, but it should probably be spelled out
here since this patch will likely need to be separated from this series
and taken via the IRQ core maintiners.

Kevin
