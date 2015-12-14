From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] cpufreq: mt8173: move resources allocation into ->probe()
Date: Tue, 15 Dec 2015 00:59:33 +0100
Message-ID: <1579627.P1F1zoisvS@vostro.rjw.lan>
References: <3188378.Wlzx7Ukr89@vostro.rjw.lan> <1449719293-7966-1-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65432 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753660AbbLNX31 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 18:29:27 -0500
In-Reply-To: <1449719293-7966-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Ricky Liang <jcliang@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Thursday, December 10, 2015 11:48:13 AM Pi-Cheng Chen wrote:
> Since the return value of ->init() of cpufreq driver is not propagated
> to the device driver model now, move resources allocation into
> ->probe() to handle -EPROBE_DEFER properly.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied along with the [1-3] in this series.

Thanks,
Rafael

