From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Allocate memory outside domain locks
Date: Thu, 05 Nov 2015 23:40:24 +0100
Message-ID: <131553331.r9oAFZFbda@vostro.rjw.lan>
References: <1446067190-42583-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62377 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751046AbbKEWLM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 17:11:12 -0500
In-Reply-To: <1446067190-42583-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: linux-pm@vger.kernel.org, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof =?utf-8?B?S296xYJvd3NraQ==?= <k.kozlowski@samsung.com>

On Wednesday, October 28, 2015 03:19:50 PM Lina Iyer wrote:
> In preparation for supporting IRQ-safe domains, allocate domain data
> outside the domain locks. These functions are not called in an atomic
> context, so we can always allocate memory using GFP_KERNEL. By
> allocating memory before the locks, we can safely lock the domain usi=
ng
> spinlocks instead of mutexes.
>=20
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Applied, thanks!

Rafael

