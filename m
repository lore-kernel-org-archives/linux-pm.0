From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] ARM: nomadik: add dynamic irq flag to the timer
Date: Fri, 1 Mar 2013 02:13:29 +0100
Message-ID: <CACRpkda=i5cXSbYCyb0gH0OLKj7396qguup1nqgqn0m-S1x1wg@mail.gmail.com>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
	<1361917047-29230-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:59105 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab3CABN3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Feb 2013 20:13:29 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so2152896iac.21
        for <linux-pm@vger.kernel.org>; Thu, 28 Feb 2013 17:13:29 -0800 (PST)
In-Reply-To: <1361917047-29230-4-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rickard ANDERSSON <rickard.andersson@stericsson.com>
Cc: john.stultz@linaro.org, tglx@linutronix.de, jacob.jun.pan@linux.intel.com, linus.walleij@stericsson.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 26, 2013 at 11:17 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> Add the dynamic irq affinity feature to the timer clock device.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Looks reasonable to me, sadly I do not fully grasp the patch set,
Vincent+Rickard can you have a look at this?

Yours,
Linus Walleij
