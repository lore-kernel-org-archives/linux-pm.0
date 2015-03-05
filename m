From: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] cpufreq-dt: add clock domain and intermediate
 frequency support
Date: Thu, 5 Mar 2015 15:28:47 +0800
Message-ID: <CALx668VZ4QMjFWssbjpZfcUKWJAYET81r3=jKHyAosUKDsbbBw@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
	<1425458956-20665-2-git-send-email-pi-cheng.chen@linaro.org>
	<CAKohpomw6iDRRMxgmOORzZVeW4h2-LzKOsUcdpUnANcxiAYm+A@mail.gmail.com>
	<CALx668XCh46yMLajThuVzba9RRSxf+tEkNuMP9J7w-=vsZN8-Q@mail.gmail.com>
	<CAKohpo=zPsezGs8rqVzx3ChQkavs5z7eFMMETe12pc2mjm-8OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpo=zPsezGs8rqVzx3ChQkavs5z7eFMMETe12pc2mjm-8OA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ashwin Chaugule <ashwin.chaugule-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen Fan <fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm@vger.k>
List-Id: linux-pm@vger.kernel.org

On 5 March 2015 at 11:58, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 5 March 2015 at 09:02, Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> In the case of Mediatek SoC, the intermediate frequency might not be one entry
>> of OPP table. To elaborate, the source clock node of the CPUs/Cluster on
>> Mediatek SoC is a mux. The mux has several PLLs as parents. When we are
>> doing CPU frequency scaling, the mux should re-parent to another stable PLL,
>> wait until the original parent PLL become stable, and then switch back to the
>> original parent. In this case, we could but we might not want the intermediate
>> frequency as part of OPP table. Therefore I save intermediate_freq instead of
>> intermediate frequency index in the cpufreq_dt_platform_datat struct.
>
> Hmm, I remember that discussion. Okay leave it as is.

Okay.

>
>> BTW, is this case that intermediate frequency is not necessarily be one entry
>> of OPP table supported in the OPPv2 bindings?
>
> Not yet, but will add a property for that.

Thanks for taking this case into consideration.

Best Regards,
Pi-Cheng
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
