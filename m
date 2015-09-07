From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: thermal: mediatek: Add cpu power cooling model
Date: Mon, 7 Sep 2015 11:39:31 +0530
Message-ID: <20150907060931.GF26760@linux>
References: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34932 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbbIGGJi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 02:09:38 -0400
Received: by pacfv12 with SMTP id fv12so88758994pac.2
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2015 23:09:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Eddie Huang <eddie.huang@mediatek.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Howard Chen <howard.chen@linaro.org>, Yingjoe Chen <yingjoe.chen@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

On 04-09-15, 17:01, Dawei Chien wrote:
> Use Intelligent Power Allocation (IPA) technical to add
> static/dynamic power model for binding CPU thermal zone.
> The power allocator governor allocates power budget to control
> CPU temperature.

Sorry but this isn't enough really.. I don't have time to go through
the code and understand the purpose of the series.

Please explain here in detail:
- Why this is needed.
- What/How you are doing it.

(Don't resend, just reply to this email :) )

-- 
viresh
