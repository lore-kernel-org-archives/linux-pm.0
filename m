From: Roger Lu <roger.lu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] PM / suspend: show workqueues busy name in suspend flow
Date: Wed, 29 Jun 2016 11:54:11 +0800
Message-ID: <1467172451.4141.20.camel@mtksdaap41>
References: <1466586509-32400-1-git-send-email-roger.lu@mediatek.com>
 <20160622152126.GV3262@mtj.duckdns.org>
 <1467020645.25092.24.camel@mtksdaap41>
 <20160628165616.GD5185@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160628165616.GD5185-piEFEHQLUPpN0TnZuCh8vA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Lai Jiangshan <jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Dear Tejun,

On Tue, 2016-06-28 at 12:56 -0400, Tejun Heo wrote:
> Hello, Roger.
> 
> On Mon, Jun 27, 2016 at 05:44:05PM +0800, Roger Lu wrote:
> > show_workqueue_state() is a better choice to me. However, only freezable
> > workqueue is able to affect suspend flow. So, is there other mailing
> > list discussing about showing freezable workqueue state only?? Maybe we
> > can use that API in this case. Thanks very much.
> > 
> > freezable workqueue means workqueue is created with flag WQ_FREEZABLE.
> 
> It's for debugging anyway and workqueue dumps usually are pretty
> short.  I don't think it's fine to use the same function.  We can add
> flags in the printouts but I'm not even sure that'd be necessary.
> 
> Thanks.
> 

Please allow me to elaborate my previous concern about printing
freezable workqueue info only in this case.

The benefit of it is that debugger can quickly understand which
freezable workqueues block suspend flow and assign this issue to
corresponding owner instead of extracting freezable workqueue info from
show_workqueue_state() first and, then, assigning the issue.

Adding a flag to printout the info we need is great. Perhaps we can do
that. Thanks for the advice.

Sincerely,
Roger Lu.
