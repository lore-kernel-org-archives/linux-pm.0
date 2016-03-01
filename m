From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/2] [RFC] PM / Domains: Join state name and index in debugfs output
Date: Tue, 01 Mar 2016 10:55:01 -0800
Message-ID: <7hlh62hvui.fsf@baylibre.com>
References: <1456246158-19673-1-git-send-email-geert+renesas@glider.be>
	<1456246158-19673-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35019 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbcCASzD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 13:55:03 -0500
Received: by mail-pa0-f47.google.com with SMTP id bj10so47964286pad.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 10:55:02 -0800 (PST)
In-Reply-To: <1456246158-19673-2-git-send-email-geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Tue, 23 Feb 2016 17:49:18 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam+renesas@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> For low-power states, the state index is part of the state, hence join
> them with a hyphen in the /sys/kernel/debug/pm_genpd/pm_genpd_summary
> output. E.g. "off 0" becomes "off-0".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Kevin Hilman <khilman@baylibre.com>
