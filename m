From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 2/5] PM / OPP: Add
 {opp-microvolt|opp-microamp|turbo-mode|opp-suspend}-<name> binding
Date: Tue, 10 Nov 2015 20:25:05 +0530
Message-ID: <20151110145505.GB5408@ubuntu>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
 <17a4388be606f21fe1d31b23180d41f6cabdd4b5.1446687367.git.viresh.kumar@linaro.org>
 <20151105030245.GA20613@rob-hp-laptop>
 <20151105031913.GA29491@ubuntu>
 <CAL_Jsq+sKbn9Jsp6LjfwO59Ceps3zrL8eABXw74m3A25M8bjJg@mail.gmail.com>
 <20151106015321.GF3773@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151106015321.GF3773@ubuntu>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 06-11-15, 07:23, Viresh Kumar wrote:
> Yeah, but in that case 1200 *may* not be a turbo frequency anymore, as
> the voltage constraints might have changed.
> 
> So turbo frequency is something that should be used only in small
> bursts, as they are consume lot of power. They aren't available to be
> used freely. They may also have thermal side effects..
> 
> In a similar way, for suspend-freq, we may or may not want the lowest
> frequency to be used during suspend and so that can change as well.
> And we shouldn't have suspend-freq set for two OPP nodes.

@Rob: Does my comments make any sense now? Or you still think we are
doing something wrong here?

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
