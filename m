From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] PM / suspend: show workqueues busy name in suspend flow
Date: Tue, 28 Jun 2016 12:56:16 -0400
Message-ID: <20160628165616.GD5185@htj.duckdns.org>
References: <1466586509-32400-1-git-send-email-roger.lu@mediatek.com>
 <20160622152126.GV3262@mtj.duckdns.org>
 <1467020645.25092.24.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33264 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbcF1Q4b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 12:56:31 -0400
Content-Disposition: inline
In-Reply-To: <1467020645.25092.24.camel@mtksdaap41>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Roger Lu <roger.lu@mediatek.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Lai Jiangshan <jiangshanlai@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, djkurtz@chromium.org, drinkcat@chromium.org, fan.chen@mediatek.com, eddie.huang@mediatek.com

Hello, Roger.

On Mon, Jun 27, 2016 at 05:44:05PM +0800, Roger Lu wrote:
> show_workqueue_state() is a better choice to me. However, only freezable
> workqueue is able to affect suspend flow. So, is there other mailing
> list discussing about showing freezable workqueue state only?? Maybe we
> can use that API in this case. Thanks very much.
> 
> freezable workqueue means workqueue is created with flag WQ_FREEZABLE.

It's for debugging anyway and workqueue dumps usually are pretty
short.  I don't think it's fine to use the same function.  We can add
flags in the printouts but I'm not even sure that'd be necessary.

Thanks.

-- 
tejun
