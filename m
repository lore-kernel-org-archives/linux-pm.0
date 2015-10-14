From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] PM / Domains: Rename *pm_genpd_poweron|poweroff()
Date: Wed, 14 Oct 2015 23:57:10 +0200
Message-ID: <2175085.7tNVMedTy4@vostro.rjw.lan>
References: <1444723082-23751-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57862 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932093AbbJNV22 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 17:28:28 -0400
In-Reply-To: <1444723082-23751-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Tuesday, October 13, 2015 09:58:02 AM Ulf Hansson wrote:
> This is another step to get consistent names of functions in genpd. Let's
> rename the internal *pm_genpd_poweron|poweroff() into
> *genpd_poweron|poweroff().
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied, thanks!

Rafael

