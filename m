From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH/RFC] PM / Domains: Minimize latencies by not delaying save/restore
Date: Mon, 11 May 2015 10:00:09 -0700
Message-ID: <7hbnhrdp7q.fsf@deeprootsystems.com>
References: <1431350673-871-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36028 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbbEKRAN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 13:00:13 -0400
Received: by pdea3 with SMTP id a3so152425915pde.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2015 10:00:13 -0700 (PDT)
In-Reply-To: <1431350673-871-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 11 May 2015 15:24:33 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, linux-arm-kernel@lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

[...]

> To address these two issues, let's change the policy in genpd. More
> precisely, let's walk the hierarchy of the ->runtime_suspend()
> callbacks immediately when genpd's ->runtime_suspend() callback at the
> PM domain level is invoked.

To help in understanding this change, you might also consider leading
with something like this paragraph.  IOW, start with an intro pargraph
about *what* you are changing, and then go into the why.  

The current changlog goes into great detail about "why" before ever
explaining the "what". 

Kevin
