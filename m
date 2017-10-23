From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: devfreq/exynos-bus: Use common error handling code in
 exynos_bus_target()
Date: Mon, 23 Oct 2017 07:53:07 +0200
Message-ID: <e84ea128-d69e-7c77-db3a-44622457f347@users.sourceforge.net>
References: <CGME20171022134057epcas4p43e6f37b8994c28f6ef240536349811a8@epcas4p4.samsung.com>
 <4a407cd6-020c-1750-019a-6c0ceb40e245@users.sourceforge.net>
 <59ED4313.701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:53118 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751043AbdJWFxn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Oct 2017 01:53:43 -0400
In-Reply-To: <59ED4313.701@samsung.com>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

> As I already commented on your other patch related to extcon-max14577,
> this patch might remove the redundant error message.

I hope that more software improvements can be achieved in this design direction.


> But, it makes the code more complicated in side of readability. I prefer existing code.

I prefer to avoid duplicated code a bit more.

Regards,
Markus
