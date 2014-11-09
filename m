From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] Ux500 core changes for v3.19
Date: Sat, 8 Nov 2014 16:53:14 -0800
Message-ID: <20141109005314.GA13855@quad.lixom.net>
References: <CACRpkda3KMkrCSDeSUycmeDUJTDFVq6hesYfLTfmoeCB3oP6MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35651 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbaKIAxQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 8 Nov 2014 19:53:16 -0500
Received: by mail-pd0-f179.google.com with SMTP id g10so5592232pdj.10
        for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2014 16:53:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACRpkda3KMkrCSDeSUycmeDUJTDFVq6hesYfLTfmoeCB3oP6MA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "arm@kernel.org" <arm@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sun, Nov 02, 2014 at 11:17:31PM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> please pull in these Ux500 core changes for this kernel development
> cycle: mainly a generic power domain implementation from Ulf Hansson
> that needs to get queued up in -next and tested.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:
> 
>   Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-core-for-arm-soc
> 
> for you to fetch changes up to 29417fe80ad2fd4f62f00dcca96c7198870e5642:
> 
>   ARM: ux500: Add i2c devices to the VAPE PM domain (2014-10-28 10:50:46 +0100)
> 
> ----------------------------------------------------------------
> Generic power domains for the Ux500
> 
> ----------------------------------------------------------------
> Joe Perches (1):
>       ARM: u300: Convert pr_warning to pr_warn
> 
> Ulf Hansson (8):
>       dt: bindings: ux500: Add documentation for PM domains
>       dt: bindings: ux500: Add header for PM domains specifiers
>       ARM: ux500: Initial support for PM domains
>       ARM: ux500: Enable Kconfig for the generic PM domain
>       ARM: ux500: Add DT node for ux500 PM domains
>       ARM: ux500: Add sdi devices to the VAPE PM domain
>       ARM: ux500: Add spi and ssp devices to the VAPE PM domain
>       ARM: ux500: Add i2c devices to the VAPE PM domain

Merged, thanks.


-Olof
