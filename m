From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] PM / suspend: show workqueues busy name in suspend flow
Date: Wed, 29 Jun 2016 09:22:01 -0400
Message-ID: <20160629132201.GC24054@htj.duckdns.org>
References: <1466586509-32400-1-git-send-email-roger.lu@mediatek.com>
 <20160622152126.GV3262@mtj.duckdns.org>
 <1467020645.25092.24.camel@mtksdaap41>
 <20160628165616.GD5185@htj.duckdns.org>
 <1467172451.4141.20.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467172451.4141.20.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Lu <roger.lu@mediatek.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Lai Jiangshan <jiangshanlai@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, djkurtz@chromium.org, drinkcat@chromium.org, fan.chen@mediatek.com, eddie.huang@mediatek.com
List-Id: linux-pm@vger.kernel.org

Hello, Roger.

On Wed, Jun 29, 2016 at 11:54:11AM +0800, Roger Lu wrote:
> Please allow me to elaborate my previous concern about printing
> freezable workqueue info only in this case.
> 
> The benefit of it is that debugger can quickly understand which
> freezable workqueues block suspend flow and assign this issue to
> corresponding owner instead of extracting freezable workqueue info from
> show_workqueue_state() first and, then, assigning the issue.

I don't think it matters.  At that point, workqueues are generally
pretty idle anyway and it shouldn't be difficult to tell which work
items are the offending ones.  Besides, freezable and unfreezable
workqueues share the same backend pools, so it isn't easily separable
either.

Thanks.

-- 
tejun
