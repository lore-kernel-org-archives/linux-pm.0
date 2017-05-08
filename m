From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 1/9] PM / OPP: Introduce "power-domain-opp" property
Date: Mon, 8 May 2017 12:41:46 +0530
Message-ID: <20170508071146.GG17010@vireshk-i7>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
 <025acedb263eaa6089d354d9630214ada8013990.1493203884.git.viresh.kumar@linaro.org>
 <20170428204803.plu467okibtxga4d@rob-hp-laptop>
 <m2inleux0w.fsf@baylibre.com>
 <20170508041511.GB17010@vireshk-i7>
 <fd54a7b8-d88f-af70-61a2-f32befac21be@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fd54a7b8-d88f-af70-61a2-f32befac21be-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

I had a long chat with Rajendra offline and clarified few things..

On 08-05-17, 11:06, Rajendra Nayak wrote:
> On 05/08/2017 09:45 AM, Viresh Kumar wrote:
> > On 06-05-17, 11:58, Kevin Hilman wrote:

> >> I had the same question.  Seems the same comment about an abstract
> >> "index" is needed for voltage also.
> > 
> > Why should we do that? Here are the cases that I had in mind while writing this:
> > 
> > - DT only contains the performance-index and nothing else (i.e. voltages aren't
> >   exposed).
> > 
> >   We wouldn't be required to fill the microvolt property as it is optional.
> 
> So the performance-index is specified in opp-hz property?

Yes, but in the OPP table of the power-domain and not the device. The
device can still have its own OPP table with normal freq/voltage
values (for a separate regulator).

> What if the microcontroller firmware maps the performance-index to voltage but
> expects linux to scale the frequency?

As you clarified on the chat, you were talking about the device here.
It isn't a problem as we will have two separate tables here, one for
the device and one for the domain.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
