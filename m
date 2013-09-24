From: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 1/3] clk: samsung: Add clock driver for s5pc110/s5pv210
Date: Tue, 24 Sep 2013 16:26:01 +0200
Message-ID: <2095838.ED3sWFjloW@amdc1227>
References: <1380027009-2239-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1380027009-2239-2-git-send-email-m.krawczuk@partner.samsung.com>
 <52419A6E.9020203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <52419A6E.9020203-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Mateusz Krawczuk <m.krawczuk-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t.stanislaws-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 24 of September 2013 15:58:06 Sylwester Nawrocki wrote:
> Hi,
> 
> On 24/09/13 14:50, Mateusz Krawczuk wrote:
> > +++ b/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt
> > @@ -0,0 +1,75 @@
> > +* Samsung S5PC110/S5PV210 Clock Controller
> > +
> > +The S5PV210 clock controller generates and supplies clock to various controllers
> > +within the SoC. The clock binding described here is applicable to all SoCs in
> > +the S5PC110/S5PV210 family.
> > +
> > +Required Properties:
> > +
> > +- compatible: should be "samsung,s5pv210-clock".
> 
> I have nothing against this compatible value, but wouldn't it be more
> accurate to use, e.g. "samsung,s5pv210-cmu" - for Clock Management Unit,
> as this IP block is also referred to in the documentation ?
> 
> May just be me, but "samsung,s5pv210-clock" sounds like just one
> specific clock type.

In the user's manual I have, this IP is referred to either as "CMU", as
you suggested, or simply as "clock controller". "CMU" is not very
meaningfull, so "samsung,s5pv210-clock-controller" would be the best here
I guess, but for consistency with other Samsung's clock bindings, I'd
suggest leaving this as is in the patch.

Best regards,
Tomasz

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
