From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] wm831x_power: Fix off-by-one at free_irq()
Date: Sun, 14 Jun 2015 14:24:33 +0100
Message-ID: <20150614132433.GK32730@opensource.wolfsonmicro.com>
References: <1434282918-6980-1-git-send-email-yos@sslab.ics.keio.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45316 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751417AbbFNNYg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jun 2015 09:24:36 -0400
Content-Disposition: inline
In-Reply-To: <1434282918-6980-1-git-send-email-yos@sslab.ics.keio.ac.jp>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Takeshi Yoshimura <yos@sslab.ics.keio.ac.jp>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jun 14, 2015 at 08:55:18PM +0900, Takeshi Yoshimura wrote:
> An error handling in wm831x_power_probe() mistakenly frees a failed-to-
> request irq as well as other irqs. I added missing decrement of the loop
> counter.
> 
> Signed-off-by: Takeshi Yoshimura <yos@sslab.ics.keio.ac.jp>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
