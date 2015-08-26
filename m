From: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH 0/3 v6] Add Mediatek MT8173 cpufreq driver
Date: Wed, 26 Aug 2015 14:53:39 +0800
Message-ID: <CALx668V2herrp6XOtCDR7nNvFhd7DLLMjXmr86cjfCOQ_cgmrw@mail.gmail.com>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
	<CALx668VWg2xVxzy8P7f5QFWRzm+TDJXUghL-_rbvRLsLYjtnng@mail.gmail.com>
	<1617873.VRHfat3V76@vostro.rjw.lan>
	<CALx668UvkYhLoU8rxLG70RqTzsnaiV5-ybDYTKqb4MEJS8pmRw@mail.gmail.com>
	<20150826021659.GD8784@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150826021659.GD8784@linux>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 26, 2015 at 10:16 AM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 26-08-15, 09:25, Pi-Cheng Chen wrote:
>> The [3/3] is based on Mediatek SoC maintainer tree[1] and the patch which
>> introduce a new clock type[2] consumed by MT8173 cpufreq driver. So it will
>> cause some conflicts if it goes through your tree. I am not sure how this
>> should be handled, but should it be merged through Mediatek SoC maintainer
>> tree?
>
> Just get that applied to MTK tree, it doesn't have any dependency on
> rest of the patches for build/boot. The only thing is that cpufreq
> wouldn't work and it will work as soon as Rafael's and MTK's trees are
> merged by Linus.

Thanks for your explanation.

@Rafael, Would you please apply [1,2] to your tree?

@Matthias, Would you please apply [3/3] of this series?

Thanks.

Best Regards,
Pi-Cheng

>
> --
> viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
