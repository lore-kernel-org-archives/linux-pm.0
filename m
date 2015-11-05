From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Remove dev->driver check for runtime PM
Date: Thu, 05 Nov 2015 23:39:57 +0100
Message-ID: <4070639.WPDbk2feK7@vostro.rjw.lan>
References: <1446067139-42360-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42245 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754274AbbKEWKp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 17:10:45 -0500
In-Reply-To: <1446067139-42360-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: linux-pm@vger.kernel.org, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>

On Wednesday, October 28, 2015 03:18:59 PM Lina Iyer wrote:
> Remove check for driver of a device, for runtime PM. Device may be
> suspended without an explicit driver. This check seems to be vestigial
> and incorrect in the current context.
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Applied, thanks!

Rafael

