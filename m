From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 02/27] gpiolib-acpi: convert acpi_evaluate_object() to acpi_execute_simple_method()
Date: Tue, 17 Sep 2013 14:55:53 +0200
Message-ID: <CACRpkdY-mqF2mm6LoJvcjNOo=hnQq8qsPc_zvfX14uMqrMM-Bw@mail.gmail.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
	<1378168335-22556-3-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:59154 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab3IQMzx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2013 08:55:53 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so5059108obc.22
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2013 05:55:53 -0700 (PDT)
In-Reply-To: <1378168335-22556-3-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Tue, Sep 3, 2013 at 2:31 AM, Zhang Rui <rui.zhang@intel.com> wrote:

> acpi_execute_simple_method() is a new ACPI API introduced to invoke
> an ACPI control method that has single integer parameter and no return value.
>
> Convert acpi_evaluate_object() to acpi_execute_simple_method()
> in drivers/gpio/gpiolib-acpi.c
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> CC: Mathias Nyman <mathias.nyman@linux.intel.com>
> CC: Mika Westerberg <mika.westerberg@linux.intel.com>
> CC: Linus Walleij <linus.walleij@linaro.org>

Patch applied with Mathias and Mika's ACKs!

Yours,
Linus Walleij
