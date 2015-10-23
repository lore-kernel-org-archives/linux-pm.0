From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 2/2] PM / Domains: Merge measurements for PM QoS device latencies
Date: Fri, 23 Oct 2015 11:49:08 -0700
Message-ID: <7h8u6tpgij.fsf@deeprootsystems.com>
References: <1444921339-22614-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32850 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbJWStK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2015 14:49:10 -0400
Received: by pabrc13 with SMTP id rc13so124916527pab.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2015 11:49:09 -0700 (PDT)
In-Reply-To: <1444921339-22614-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Thu, 15 Oct 2015 17:02:19 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Measure latency does by itself contribute to an increased latency, thus we
> should avoid it when it isn't needed.
>
> By merging the latency measurements for the ->save_state() and the
> ->stop() callbacks, we get one measurement instead of two and we get one
> value to store instead of two. Let's also apply the likewise change for
> the ->start() and ->restore_state() callbacks.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>
