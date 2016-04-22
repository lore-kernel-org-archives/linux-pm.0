From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/3] PM / Domains: Further consolidate and clarify genpd code
Date: Thu, 21 Apr 2016 17:19:19 -0700
Message-ID: <7hwpnq4hrs.fsf@baylibre.com>
References: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33360 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbcDVATW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 20:19:22 -0400
Received: by mail-pf0-f182.google.com with SMTP id 184so35315266pff.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2016 17:19:21 -0700 (PDT)
In-Reply-To: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Thu, 31 Mar 2016 11:21:24 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> This is yet another quite trivial series of patches that further intends to
> consolidate and clarify some of the code for the generic PM domain (genpd).
>
> Ulf Hansson (3):
>   PM / Domains: Rename stop_ok to suspend_ok for the genpd governor
>   PM / Domains: Rename pm_genpd_runtime_suspend|resume()
>   PM / Domains: Remove ->save|restore_state() callbacks

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

with an enthusiastic yes!  :)

Thanks for the cleanups and clarifications.

Kevin
