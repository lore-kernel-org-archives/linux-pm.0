From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Fix validation of latency constraints in genpd governor
Date: Wed, 14 Oct 2015 23:57:42 +0200
Message-ID: <2705969.mRLJtFuguk@vostro.rjw.lan>
References: <1444745428-4396-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51047 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932093AbbJNV27 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 17:28:59 -0400
In-Reply-To: <1444745428-4396-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Tuesday, October 13, 2015 04:10:28 PM Ulf Hansson wrote:
> Commit ba2bbfbf6307 ("PM / Domains: Remove intermediate states from the
> power off sequence") changed the power off sequence in genpd. That also
> required some updates regarding the validation of latency constraints in
> the genpd governor. Unfortunate that wasn't covered, so let's fix this.
> 
> From a runtime PM and latency point of view, we need to consider the worst
> case scenario while validating latency constraints. That's typically when
> a call to pm_runtime_get_sync() needs to wait for a ongoing runtime
> suspend operation to be carried out, as it then also needs to wait for the
> device to be runtime resumed again.
> 
> The above mentioned commit made the genpd governor's ->stop_ok() callback
> responsible of validating genpd's device's runtime suspend/resume latency.
> In other words, the constraint needs to be validated towards the relevant
> latencies present in genpd's ->runtime_suspend|resume() callbacks.
> 
> Earlier, that included latencies from the ->stop|start() callbacks, but as
> ->save|restore_state() are now also being invoked from genpd's
> ->runtime_suspend|resume() and to comply with the worst case scenario,
> let's take also those latencies into account.
> 
> Fixes: ba2bbfbf6307 ("PM / Domains: Remove intermediate states from the
> power off sequence")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied, thanks!

Rafael

