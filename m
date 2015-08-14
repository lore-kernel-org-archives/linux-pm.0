From: Kukjin Kim <kgene@kernel.org>
Subject: RE: [PATCH] cpufreq: exynos: Fix for memory leak in case SoC name does
 not match
Date: Fri, 14 Aug 2015 18:34:10 +0900
Message-ID: <023401d0d674$5fb56c20$1f204460$@kernel.org>
References: <04f401d0ce89$81073900$8315ab00$@kernel.org>
 <9283770.jQmuxWnYst@vostro.rjw.lan> <55C5B182.6000509@samsung.com>
 <2470259.jrumdYRmlv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <2470259.jrumdYRmlv@vostro.rjw.lan>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Krzysztof Kozlowski' <k.kozlowski@samsung.com>
Cc: 'Kukjin Kim' <kgene@kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Lukasz Majewski' <l.majewski@samsung.com>, linux-samsung-soc@vger.kernel.org, 'Linux PM list' <linux-pm@vger.kernel.org>, shailendra.capricorn@gmail.com
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> 
> On Saturday, August 08, 2015 04:36:34 PM Krzysztof Kozlowski wrote:
> > W dniu 06.08.2015 o 09:23, Rafael J. Wysocki pisze:
> > > On Tuesday, August 04, 2015 04:45:16 PM Kukjin Kim wrote:
> > >> From: Shailendra Verma <shailendra.capricorn@gmail.com>
> > >>
> > >> During probe free the memory allocated to "exynos_info" in case of
> > >> unknown SoC type.
> > >>
> > >> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> > >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
> > >> [k.kozlowski: Rebased the patch around if(of_machine_is_compatible)]
> > >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > >> Signed-off-by: Kukjin Kim <kgene@kernel.org>
> > >> ---
> > >> Hi Rafael and Viresh,
> > >>
> > >> Since this is a fix to prevent memory leak, it would be better if
> > >> this could be sent to linus during -rc via cpufreq tree.
> > >
> > > I'm not planning more pull requests for 4.2 and this one doesn't seem to be
> > > a good enough reason for a pull request of its own, though.
> > >
> > > Of course, if there are more urgent fixes, I can push it along with them,
> > > but there are none so far.
> >
> > The cpufreq driver will be removed completely in v4.3 or v4.4 with
> > patchset adding cpufreq-dt support for Exynos 4x12. This means that this
> > patch makes sense only for 4.2 and as a stable backport (but it was not
> > marked as such).
> 
> Since I have one more ACPI fix for 4.2, I've applied this one and will
> push it to Linus next week.
> 
Rafael, thanks.

- Kukjin
