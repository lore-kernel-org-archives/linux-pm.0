From: Chris Brand <chris.brand@broadcom.com>
Subject: Re: [PATCH 0/6] Support BCM23550 SoC
Date: Mon, 9 May 2016 15:31:31 -0700
Message-ID: <CAMsMSK-MwY6HDmb45vj6g2BTM9yk7+g5oP0hEm9gk6Gi7f+XjA@mail.gmail.com>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
	<6872671.Czyv7J9iJZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37797 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbcEIWbd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 18:31:33 -0400
Received: by mail-ig0-f174.google.com with SMTP id s8so104135875ign.0
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2016 15:31:32 -0700 (PDT)
In-Reply-To: <6872671.Czyv7J9iJZ@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Russell King <linux@armlinux.org.uk>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Raymond Ngun <raymond.ngun@broadcom.com>, Markus Mayer <markus.mayer@broadcom.com>

On Thu, May 5, 2016 at 2:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
[...]
> Looks really nice overall, I only found one tiny detail I commented on
> for patch 6.

Thanks!

> I'm glad to see work on the old chips resume, are you working on new
> code for it as well, or just upstreaming the patches that were already
> done in the past?


This is new work. It was actually a good testament to the value of
upstreaming that it was so easy to bring up a 4.6 kernel on this chip.

Chris
