From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Date: Tue, 23 Jun 2015 01:41:04 +0200
Message-ID: <5913118.ZpKlm0JFgd@vostro.rjw.lan>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be> <1434958282-27376-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56741 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751370AbbFVXO6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 19:14:58 -0400
In-Reply-To: <1434958282-27376-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <damm@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 22, 2015 09:31:22 AM Geert Uytterhoeven wrote:
> If pm_genpd_{add,remove}_device() keeps on failing with -EAGAIN, we end
> up with an infinite loop in genpd_dev_pm_{at,de}tach().
> 
> This may happen due to a genpd.prepared_count imbalance.  This is a bug
> elsewhere, but it will result in a system lock up, possibly during
> reboot of an otherwise functioning system.
> 
> To avoid this, put a limit on the maximum number of loop iterations,
> including a simple back-off mechanism.  If the limit is reached, the
> operation will just fail.  An error message is already printed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This was too late for my first 4.2 pull request, but I may push it in the
second half of the merge window.  Does it depend on anything?

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
