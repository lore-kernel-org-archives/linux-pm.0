From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/1] drivers: cpuidle: cpuidle-arm: heterogeneous
 systems extension
Date: Tue, 14 Jul 2015 11:04:51 +0100
Message-ID: <20150714100451.GA16165@red-moon>
References: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1429200617-9546-2-git-send-email-lorenzo.pieralisi@arm.com>
 <554771D3.5010701@linaro.org>
 <20150505155615.GA23106@red-moon>
 <20150512130339.GB15131@red-moon>
 <CAGS+omBtraNBH43qsFn_YgO3ePbFav9VtwgqDUinbOBMPwOGXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGS+omBtraNBH43qsFn_YgO3ePbFav9VtwgqDUinbOBMPwOGXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Howard Chen <howard.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Eddie Huang (?????????)" <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Tue, Jul 14, 2015 at 05:52:48AM +0100, Daniel Kurtz wrote:

[...]

> > Any further comments ? I can post a v2 with an updated idle_states_cmp()
> > return value, if we think the multiple drivers approach is valid.
> 
> Can you post v2?
> From the silence on the list, I guess there is no strong objection to
> your approach.

I just wanted to make sure this patch is strictly required before asking
for a merge in the mainline, it adds to the code complexity so it should
not be taken lightly.

> So, perhaps it is time to remove the "RFC" as well so this can get on
> track to be merged.

I will drop the RFC status and add a simple configuration to define
a config entry to configure the max number of drivers statically so
that we do not waste memory for nothing.

Thanks,
Lorenzo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
