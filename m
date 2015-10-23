From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 1/2] PM / Domains: Don't measure ->start|stop() latency in system PM callbacks
Date: Fri, 23 Oct 2015 11:48:11 -0700
Message-ID: <7hd1w5pgk4.fsf@deeprootsystems.com>
References: <1444921326-22574-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34351 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbbJWSsN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2015 14:48:13 -0400
Received: by padhk11 with SMTP id hk11so125292895pad.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2015 11:48:13 -0700 (PDT)
In-Reply-To: <1444921326-22574-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Thu, 15 Oct 2015 17:02:06 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Measure latency does by itself contribute to an increased latency, thus we
> should avoid it when it isn't needed.
>
> Genpd measures latencies in the system PM phase for the ->start|stop()
> callbacks and is thus affecting the system PM suspend/resume time.
> Moreover these latencies are validated only at runtime PM suspend/resume.
>
> To this reasoning, let's decide to leave these measurements out of the
> system PM phase. There should be plenty of occasions during runtime PM to
> perform these measurements anyway.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>
