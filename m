From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v4 1/9] PM / Domains: Change prototype for the ->attach_dev() callback
Date: Mon, 03 Nov 2014 19:15:04 +0100
Message-ID: <8761ewduc7.fsf@igel.home>
References: <1415028896-9005-1-git-send-email-geert+renesas@glider.be>
	<1415028896-9005-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:57130 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbaKCSPK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 13:15:10 -0500
In-Reply-To: <1415028896-9005-2-git-send-email-geert+renesas@glider.be> (Geert
	Uytterhoeven's message of "Mon, 3 Nov 2014 16:34:48 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Convert the prototype to return and int. This is just an initial step,

s/and/an/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
