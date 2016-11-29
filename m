From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 3/5] thermal: rockchip: fixes invalid temperature case
Date: Tue, 29 Nov 2016 13:57:45 -0800
Message-ID: <20161129215744.GA99997@google.com>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-4-git-send-email-wxt@rock-chips.com>
 <20161129014553.GA3097@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161129014553.GA3097-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

I'm not sure I completely understand what you're asking, but I'll see
what I can answer.

On Mon, Nov 28, 2016 at 05:45:54PM -0800, Eduardo Valentin wrote:
> On Mon, Nov 28, 2016 at 07:12:02PM +0800, Caesar Wang wrote:
> > The temp_to_code function will return 0 when we set the temperature to a
> > invalid value (e.g. 61C, 62C, 63C....), that's unpractical. This patch
> > will prevent this case happening. That will return the max analog value to
> > indicate the temperature is invalid or over table temperature range.
> 
> <cut>
> 
> >  
> >  	/* Make sure the value is valid */
> >  	alarm_value = rk_tsadcv2_temp_to_code(table, temp);
> 
> dummy question here, looking at your tables, if I did not miss
> something, looks like we have an accuracy of 5C steps. Not only, that,
> we also support only multiples of 5C temperatures. If that observation

Currently, that's true I think. But patch 4 actually supports doing the
linear interpolation that is claimed (but not fully implemented) in the
comments today. So with that patch, we roughly support temperatures in
between the 5C intervals.

> is correct, would it make more sense to simply check for this property,

I'm not quite sure what you mean by "this property." Do you mean to just
assume that there will be 5C intervals, and jump ahead in the table
accordingly? Seems a bit fragile; nothing really guarantees that a
future ADC supported by this driver won't have 1, 2, 6, or 7C accuracy
(and therefore a different set of steps).

> and min and max temperature check, instead of going through the binary
> search to check for valid temperature? 

I was thinking while reviewing that the binary search serves more to
complicate things than to help -- it's much harder to read (and validate
that the loop termination logic is correct). And searching through a few
dozen table entries doesn't really get much benefit from a O(n) ->
O(log(n)) speed improvement.

Anyway, I'm not sure if you were thinking along the same lines as me.

Brian
