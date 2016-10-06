From: Markus Mayer <markus.mayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [RESEND PATCH v2 2/3] cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq
 driver for Broadcom STB SoCs
Date: Thu, 6 Oct 2016 07:51:59 -0700
Message-ID: <CAGt4E5sWLbGO7b7mX5CHKRDbtp5iqaapbV=YUJbRVHyCeJL8nQ@mail.gmail.com>
References: <1475272561-8446-1-git-send-email-mmayer@broadcom.com>
 <1475272561-8446-3-git-send-email-mmayer@broadcom.com> <20161005032509.GG4664@vireshk-i7>
 <CAGt4E5s9UBam4RKsq3k1P77-81NR-8AeQi==7dBNnp37xxtr_g@mail.gmail.com> <20161006040139.GA17619@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161006040139.GA17619@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 5 October 2016 at 21:01, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Thanks for accepting all the comments :)
>
> On 05-10-16, 14:04, Markus Mayer wrote:
>> Is there an easy way for me to know via the framework whether init is
>> being called for the first time vs. init is being called on a
>> different core after a previous attempt to initialize on another core
>> failed?
>>
>> I could use a driver-global variable for the driver to remember if it
>> has been initialized, but that seems a bit hacky.
>
> You don't really need to have any special code here, specially for the case that
> may never get hit. For example, if we fail to initialize something for CPU0,
> cpufreq core will try calling this routine for other CPUs as well. I don't think
> there is anything wrong in letting cpufreq core trying that. Why stop it or
> return early? It wouldn't happen normally, unless there is a bug in there.

During early development, when the driver couldn't fully register, I
would see the init() function called four times, i.e. once for each
core. If the first call succeeded, that was it. It would only get
called once. But if it failed, all cores would try to register. And I
wanted to avoid spilling the same error message four times.

I'll look at that again. It may have had something to do with how the
driver worked back then. If it doesn't happen anymore, I'll just get
rid of this code.

Thanks,
-Markus
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
