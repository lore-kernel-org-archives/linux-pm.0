From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: ux500: u8500_defconfig: add missing cpuidle option
Date: Mon, 14 Oct 2013 11:10:20 +0200
Message-ID: <CACRpkdZ856omBFmLTQoPH_QkobkYj4tAgvHEmVZzA8+SOvYwRA@mail.gmail.com>
References: <1380540996-18521-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39873 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797Ab3JNJKV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 05:10:21 -0400
Received: by mail-ie0-f175.google.com with SMTP id aq17so10060705iec.6
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2013 02:10:20 -0700 (PDT)
In-Reply-To: <1380540996-18521-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, patches@linao.org

On Mon, Sep 30, 2013 at 1:36 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> With the commit d3f2950f2adeea3da0317e952914b59adaa4cdb3, the option
> ARM_U8500_CPUIDLE was added to the Kconfig but not reflected in the
> default config file, hence the cpuidle driver is no longer enabled
> since this commit.
>
> Enable it again by adding the missing option in the default config file.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Patch applied. Sorry for taking so long...

Yours,
Linus Walleij
