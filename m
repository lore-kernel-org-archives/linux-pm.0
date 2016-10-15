From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH v2 0/4] PXA cpufreq conversion to clock API
Date: Sat, 15 Oct 2016 21:34:21 +0100
Message-ID: <20161015203421.GG1041@n2100.armlinux.org.uk>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1476561450-28407-1-git-send-email-robert.jarzmik-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 15, 2016 at 09:57:26PM +0200, Robert Jarzmik wrote:
> Hi,
> 
> This serie is a preparation to shift the cpufreq of pxa2xx platforms to clocks
> API.
> 
> The first 3 patches are review and merge material :
>  - patch 1/4 for Viresh and Rafael
>  - patches 2/4 and 3/4 for me
> 
> The 4th on is for review but not merge, as the clock changes must be fully
> reviewed and go in first as a prequisite

Have you tested whether this patch set results in functional cpufreq
support - looking at drivers/clk/pxa, the CPU clock is read-only -
it can't be used to change the clock rate.  So, I very much doubt this
has been functionally tested.

Don't forget that changing the CPU clock rate needs other changes
(like the memory clock rate) so all that code you're removing in
patch 4 (which does the actual clock change) needs to go somewhere.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
