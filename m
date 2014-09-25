From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Domains: Remove legacy API for adding devices through DT
Date: Thu, 25 Sep 2014 15:10:21 -0700
Message-ID: <7hppej9ws2.fsf@deeprootsystems.com>
References: <1411660199-2022-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44794 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632AbaIYWKX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Sep 2014 18:10:23 -0400
In-Reply-To: <1411660199-2022-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Thu, 25 Sep 2014 17:49:59 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> There are no active clients of the legacy API and we now also have a
> better way to handle genpd DT support. So let's remove the legacy API.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>
