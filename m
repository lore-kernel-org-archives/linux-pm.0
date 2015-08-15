From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [RFC PATCH 0/8] clk: qoriq: Move chip-specific knowledge into
 driver
Date: Sat, 15 Aug 2015 01:43:37 -0500
Message-ID: <1439621017.15601.23.camel@freescale.com>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
	 <20150811182535.31346.52965@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150811182535.31346.52965@quantum>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tang Yuantian <Yuantian.Tang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Liberman Igal-B31950 <Igal.Liberman-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Bucur Madalin-Cristian-B32716 <madalin.bucur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2015-08-11 at 11:25 -0700, Michael Turquette wrote:
> Hi Scott,
> 
> Quoting Scott Wood (2015-06-18 19:49:10)
> > The existing device tree bindings are error-prone and inflexible. 
> > Correct the mistake by moving the knowledge into the driver, which
> > has more flexibility in describing the quirks of each chip.  This leaves
> > the device tree to its proper role of identifying a programming interface
> > rather than describing its individual registers.
> 
> Sorry for not responding to this one sooner. Fell through the cracks.
> 
> All of the changes to drives/clk/clk-qoriq.c look great to me. I assume
> you need to keep all of these patches together and want to the take
> through the freescale tree? If so feel free to add,
> 
> Acked-by: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

I just sent a non-RFC v2, with improved compatibility with old device trees 
(especially ls1021a).  It depends on the cpufreq patch though (at least, to 
avoid breaking qoriq-cpufreq until that patch is merged), so I'll also need 
an ack from Rafael for that if I'm taking it through my tree.

-Scott

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
