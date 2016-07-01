From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] PM / suspend: show workqueue state in suspend flow
Date: Fri, 1 Jul 2016 11:09:42 -0500
Message-ID: <20160701160942.GC28719@htj.duckdns.org>
References: <1467342302-16129-1-git-send-email-roger.lu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32834 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbcGAQJu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2016 12:09:50 -0400
Content-Disposition: inline
In-Reply-To: <1467342302-16129-1-git-send-email-roger.lu@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Roger Lu <roger.lu@mediatek.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Lai Jiangshan <jiangshanlai@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jul 01, 2016 at 11:05:02AM +0800, Roger Lu wrote:
> If freezable workqueue aborts suspend flow, show
> workqueue state for debug purpose.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Acked-by: Tejun Heo <tj@kernel.org>

Rafael, can you please pick this on up?

Thanks.

-- 
tejun
