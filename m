From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] MFD / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Wed, 31 Dec 2014 09:14:25 +0100
Message-ID: <CACRpkdYJSE9r2XYojD3213--+05W7r-jEXcyM+2MiRwH86j8Ag@mail.gmail.com>
References: <2857906.7ft1XTNUKe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:45566 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbaLaIO0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Dec 2014 03:14:26 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so14689510iec.11
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2014 00:14:26 -0800 (PST)
In-Reply-To: <2857906.7ft1XTNUKe@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Dec 4, 2014 at 1:54 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
>
> Replace CONFIG_PM_RUNTIME with CONFIG_PM everywhere under
> drivers/mfd/.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
