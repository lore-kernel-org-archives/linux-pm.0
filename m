From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 1/3] ARM: ux500: Initial support for power domains
Date: Wed, 23 Apr 2014 09:18:12 +0200
Message-ID: <CACRpkdZANqUn=_7FMO+hYLLafM4tnMTZmrj-ffGiu3=Eh=bRSQ@mail.gmail.com>
References: <1397653511-19226-1-git-send-email-ulf.hansson@linaro.org>
	<1397653511-19226-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34465 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbaDWHSM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Apr 2014 03:18:12 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp4so597329obc.7
        for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2014 00:18:12 -0700 (PDT)
In-Reply-To: <1397653511-19226-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Apr 16, 2014 at 3:05 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Initial support for power domains for ux500. To enable this feature we
> require to use DT, thus we need to add bindings for the ux500 specific
> parts as well.
>
> The implementation of the ux500 power domains is based upon the generic
> power domain.
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This looks all right to me.

But I guess we need to wait for Tomasz stuff to percolate into
the tree before I can apply this?

Also the DT people should give some hints on the bindings ideally.

Yours,
Linus Walleij
