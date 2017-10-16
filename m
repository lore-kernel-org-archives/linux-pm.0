From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] cpufreq: imx6q: Move speed grading check to cpufreq driver
Date: Mon, 16 Oct 2017 08:46:10 -0200
Message-ID: <CAOMZO5DTtE12znCVbA1YG=1ugggn1fqfbsuCXnkFTwV8b=yNEg@mail.gmail.com>
References: <1506784606-2064-1-git-send-email-festevam@gmail.com>
 <20171013065141.GI8833@dragon> <CAOMZO5AwB_2Nbky1wA8neU2-2-LDCTCMFOKGQk4jn5O9zuwKpQ@mail.gmail.com>
 <5060748.qBWaaqo0sL@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:55358 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdJPKqL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 06:46:11 -0400
Received: by mail-oi0-f66.google.com with SMTP id g125so24360219oib.12
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2017 03:46:11 -0700 (PDT)
In-Reply-To: <5060748.qBWaaqo0sL@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, vireshk@kernel.org, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Yongcai Huang <anson.huang@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Otavio Salvador <otavio.salvador@ossystems.com.br>, Fabio Estevam <fabio.estevam@nxp.com>

On Sun, Oct 15, 2017 at 10:13 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> It could go in via the PM tree (which covers cpufreq), but I'd prefer
> it to go in via arm-soc.

Sounds good for me. In this case I think Shawn will apply it.

Thanks
