From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Remove in_progress counter from struct generic_pm_domain
Date: Mon, 12 Oct 2015 23:59:08 +0200
Message-ID: <20644572.luhbNNgN8B@vostro.rjw.lan>
References: <1443532357-3157-1-git-send-email-ulf.hansson@linaro.org> <20150929145641.GH19183@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63742 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751284AbbJLVa3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2015 17:30:29 -0400
In-Reply-To: <20150929145641.GH19183@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Tuesday, September 29, 2015 08:56:41 AM Lina Iyer wrote:
> On Tue, Sep 29 2015 at 07:12 -0600, Ulf Hansson wrote:
> >Commit ba2bbfbf6307 ("PM / Domains: Remove intermediate states..") changed
> >the power off sequence (pm_genpd_poweroff()), which from locking point of
> >view means the genpd mutex is held throughout the sequence.
> >
> >The above change means the in_progress counter can't be updated while
> >pm_genpd_poweroff() is executing, which allows us to remove the counter.
> >
> >Instead we inform pm_genpd_poweroff() via a bool parameter, to indicate
> >whether we call it from the scheduled work or from the ->runtime_suspend()
> >callback, since that all that matters.
> >
> >Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Reviewed-by: Lina Iyer <lina.iyer@linaro.org>

Queued up for v4.4, thanks!

Rafael

