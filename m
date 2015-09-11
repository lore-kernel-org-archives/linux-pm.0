From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Domains: Remove name based API for genpd
Date: Fri, 11 Sep 2015 10:58:50 -0700
Message-ID: <7h8u8c25yd.fsf@deeprootsystems.com>
References: <1441893650-19923-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33064 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbIKR6x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 13:58:53 -0400
Received: by pacex6 with SMTP id ex6so81211340pac.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2015 10:58:52 -0700 (PDT)
In-Reply-To: <1441893650-19923-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Thu, 10 Sep 2015 16:00:50 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> As all users of the named based APIs now have converted to the non-named
> based APIs, the time has come to remove them.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>
