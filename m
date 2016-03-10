From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM / Domains: Restore alignment of slaves in debugfs output
Date: Fri, 11 Mar 2016 00:22:20 +0100
Message-ID: <1678167.MG94otLuA0@vostro.rjw.lan>
References: <1456246158-19673-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43184 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753838AbcCJXU0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2016 18:20:26 -0500
In-Reply-To: <1456246158-19673-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam+renesas@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org

On Tuesday, February 23, 2016 05:49:17 PM Geert Uytterhoeven wrote:
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

Both this one and the [2/2] applied, thanks!

Rafael

