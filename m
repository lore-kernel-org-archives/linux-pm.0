From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: exynos: Fix for memory leak in case SoC name does not match
Date: Fri, 14 Aug 2015 11:41:59 +0200
Message-ID: <2470259.jrumdYRmlv@vostro.rjw.lan>
References: <04f401d0ce89$81073900$8315ab00$@kernel.org> <9283770.jQmuxWnYst@vostro.rjw.lan> <55C5B182.6000509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46917 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752744AbbHNJOm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 05:14:42 -0400
In-Reply-To: <55C5B182.6000509@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, shailendra.capricorn@gmail.com

On Saturday, August 08, 2015 04:36:34 PM Krzysztof Kozlowski wrote:
> W dniu 06.08.2015 o 09:23, Rafael J. Wysocki pisze:
> > On Tuesday, August 04, 2015 04:45:16 PM Kukjin Kim wrote:
> >> From: Shailendra Verma <shailendra.capricorn@gmail.com>
> >>
> >> During probe free the memory allocated to "exynos_info" in case of
> >> unknown SoC type.
> >>
> >> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
> >> [k.kozlowski: Rebased the patch around if(of_machine_is_compatible)]
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Signed-off-by: Kukjin Kim <kgene@kernel.org>
> >> ---
> >> Hi Rafael and Viresh,
> >>
> >> Since this is a fix to prevent memory leak, it would be better if
> >> this could be sent to linus during -rc via cpufreq tree.
> > 
> > I'm not planning more pull requests for 4.2 and this one doesn't seem to be
> > a good enough reason for a pull request of its own, though.
> > 
> > Of course, if there are more urgent fixes, I can push it along with them,
> > but there are none so far.
> 
> The cpufreq driver will be removed completely in v4.3 or v4.4 with
> patchset adding cpufreq-dt support for Exynos 4x12. This means that this
> patch makes sense only for 4.2 and as a stable backport (but it was not
> marked as such).

Since I have one more ACPI fix for 4.2, I've applied this one and will
push it to Linus next week.

Thanks,
Rafael

