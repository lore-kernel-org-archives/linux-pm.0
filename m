From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 1/2] arm: irq: Notify affinity change when migrating IRQs during hotplug
Date: Wed, 27 Aug 2014 10:09:10 -0700
Message-ID: <7hegw1g8qx.fsf@paris.lan>
References: <1408553988-63924-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:64000 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935207AbaH0RJR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 13:09:17 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so622159pdj.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 10:09:16 -0700 (PDT)
In-Reply-To: <1408553988-63924-1-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Wed, 20 Aug 2014 10:59:47 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: tglx@linutronix.de, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, ulf.hansson@linaro.org, Praveen Chidambaram <pchidamb@codeaurora.org>

Lina Iyer <lina.iyer@linaro.org> writes:

> From: Praveen Chidambaram <pchidamb@codeaurora.org>
>
> Hotplug causes IRQs affine to a core that is being taken down to migrate
> to an online core. This is done by directly calling the irq_set_affinity
> associated with the irq_chip structure. Instead using the
> irq_set_affinity_locked() api lets the notifications bubble through.

changelog nit: and why do you want/need the notification to bubble
through?   IOW, you're explaining "what" the patch does, but not "why",
which typically includes a summary of the problem being solved.  (I know
the background from the other series, but other reviewers may not know
the history there.)

Also, please post these to linux-arm-kernel.

Thanks,

Kevin
