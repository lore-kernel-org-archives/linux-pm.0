From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Mon, 2 Nov 2015 11:20:37 -0800
Message-ID: <20151102192037.GP19782@codeaurora.org>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
 <20151030221826.GM19782@codeaurora.org>
 <20151031022003.GV3716@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151031022003.GV3716@ubuntu>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 10/31, Viresh Kumar wrote:
> On 30-10-15, 15:18, Stephen Boyd wrote:
> 
> > Also, this makes it sound like opp-supported-hw is really just
> > telling us if this is a supported frequency or not for the
> > particular device we're running on.
> 
> That's right.
> 
> > The current wording makes it
> 
> Of the commit log ? Or the way the nodes are written?

The way the documentation is written.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
