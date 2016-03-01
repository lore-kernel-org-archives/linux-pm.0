From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] PM / Domains: Restore alignment of slaves in debugfs output
Date: Tue, 01 Mar 2016 10:54:48 -0800
Message-ID: <7hpovehvuv.fsf@baylibre.com>
References: <1456246158-19673-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34930 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbcCASyu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 13:54:50 -0500
Received: by mail-pf0-f174.google.com with SMTP id w128so73060599pfb.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 10:54:50 -0800 (PST)
In-Reply-To: <1456246158-19673-1-git-send-email-geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Tue, 23 Feb 2016 17:49:17 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam+renesas@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> The slave domains are no longer aligned with the table header in the
> /sys/kernel/debug/pm_genpd/pm_genpd_summary output. Worse, the alignment
> differs depending on the actual name of the state.
>
> Format the state name and index into a buffer, and print that like
> before to restore alignment.
>
> Use "%u" for unsigned int while we're at it.
>
> Fixes: fc5cbf0c94b6f7fd ("PM / Domains: Support for multiple states")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Kevin Hilman <khilman@baylibre.com>
