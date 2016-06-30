From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] PM / suspend: show workqueue state in suspend flow
Date: Thu, 30 Jun 2016 04:51:03 -0500
Message-ID: <20160630095103.GB28719@htj.duckdns.org>
References: <1467256666-27808-1-git-send-email-roger.lu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467256666-27808-1-git-send-email-roger.lu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Lu <roger.lu@mediatek.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Lai Jiangshan <jiangshanlai@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Thu, Jun 30, 2016 at 11:17:46AM +0800, Roger Lu wrote:
> +		if (wq->flags & WQ_FREEZABLE)
> +			pr_info("freezable ");

The flag is already printed below and doing this will make the output
more difficult to read.

>  		pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);

Thanks.

-- 
tejun
