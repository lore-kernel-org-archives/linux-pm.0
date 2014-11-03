From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [RFC Patch 2/4] mfd: AXP20x: Add power supply sub-driver
Date: Mon, 3 Nov 2014 21:14:56 +0100
Message-ID: <20141103211456.2eb13a6e@neptune.home>
References: <20141020215954.7f1d5502@neptune.home>
	<20141020223320.2b4ecba9@neptune.home>
	<20141023201235.3b94cc82@smutje.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:58327 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbaKCUPB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 15:15:01 -0500
In-Reply-To: <20141023201235.3b94cc82@smutje.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Edgar Toernig <froese@gmx.de>
Cc: linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Thu, 23 October 2014 Edgar Toernig <froese@gmx.de> wrote:
> > +	getnstimeofday(&ts);
> > +	/* only query hardware if our data is stale */
> > +	spin_lock(&devdata->lock);
> > +	if (!init && !(ts.tv_sec > devdata->next_check.tv_sec ||
> > +	               ts.tv_nsec > devdata->next_check.tv_sec)) {
> > +		spin_unlock(&devdata->lock);
> > +		return 0;
> > +	}
> > +	spin_unlock(&devdata->lock);
> 
> That time comparison is broken - it compares nsec with sec and
> doesn't check that secs are equal before comparing the nsecs.
> There's timespec_compare which gets it right.

Oops, yeah, going to switch to timespec_compare().
Thanks for spotting!

> Btw, you are aware that the timeofday is a user adjustable
> value?  If I ever turn back system time I won't get power
> data any more until the old (future) time is reached.

Huh, no, I didn't consider that.

> Wouldn't it be easier to simply use jiffies and limit the
> poll rate to one second or so?

I considered limiting to some arbitrary polling rate though think
it's better to give users the option to query values more often,
up to the rate at which the value are measured by AXP.
As the AXP's measurement rate is configurable (not exposed by
driver) it's better to base on that setting instead of having
to care at the time of exposing the configuration knob.

Thus jiffies seem to be a bit at their limit. Is using ktime better?


Bruno
