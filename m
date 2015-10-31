From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Sat, 31 Oct 2015 07:50:03 +0530
Message-ID: <20151031022003.GV3716@ubuntu>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
 <20151030221826.GM19782@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151030221826.GM19782-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 30-10-15, 15:18, Stephen Boyd wrote:
> A side-note. I wonder if it would be better style to have the
> node name be:
> 
> 		opp@600000000 {

I thought the @... had a special meaning and we might end up creating
some device for the node then? Perhaps I am mistaken.

But then, yeah it will make it more readable as you mentioned.

> At least it seems that the assumption is we can store all the
> possible combinations of OPP values for a particular frequency in
> the same node. Following this style would make dt compilation
> fail if two nodes have the same frequency.

Right.

> Also, this makes it sound like opp-supported-hw is really just
> telling us if this is a supported frequency or not for the
> particular device we're running on.

That's right.

> The current wording makes it

Of the commit log ? Or the way the nodes are written?

> sound like we could have two OPP nodes with the same frequency
> but different voltages inside them, which we're trying to
> discourage by compressing the tables into less nodes.

No no, we can't have two nodes with same frequency.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
