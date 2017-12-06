From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/3] PM / core: Re-factor some code dealing with parents in __device_suspend()
Date: Wed, 06 Dec 2017 02:01:48 +0100
Message-ID: <2050610.MHQahEpVux@aspire.rjw.lan>
References: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org> <1510588003-16650-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51244 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754449AbdLFBCX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 20:02:23 -0500
In-Reply-To: <1510588003-16650-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org

On Monday, November 13, 2017 4:46:41 PM CET Ulf Hansson wrote:
> Let's make the code a bit more readable by moving some of the code, which
> deals with adjustments for parent devices in __device_suspend(), into its
> own function.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks!
