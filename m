From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v2 2/3] PM / devfreq: tegra: add devfreq driver for Tegra
 Activity Monitor
Date: Tue, 25 Nov 2014 09:56:34 +0100
Message-ID: <CAAObsKDYuEhX_mJ-ae0w6+zVPx26QCotb6StGY5U1JBPttPa4A@mail.gmail.com>
References: <715439136.113681416899252854.JavaMail.weblogic@epmlwas08c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <715439136.113681416899252854.JavaMail.weblogic@epmlwas08c>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 25 November 2014 at 08:07, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> The ACTMON block can monitor several counters, providing averaging and firing
>> interrupts based on watermarking configuration. This implementation monitors
>> the MCALL and MCCPU counters to choose an appropriate frequency for the
>> external memory clock.
>>
>> This patch is based on work by Alex Frid <afrid-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> and Mikko
>> Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> How are you going to integrate other two patches?

I think they should go through the Tegra tree.

> May I just go ahead with this patch only?

Yes, I think that would be fine as the other patches aren't actual
build or runtime dependencies. This driver shouldn't cause problems
either if it's ran without the EMC and CPUFreq patches (though won't
be fully functional, of course).

Regards,

Tomeu

> Cheers,
> MyungJoo.
>
>>
>> ---
>>
>> v2:   * Use devfreq
>> ---
>>  drivers/devfreq/Kconfig         |  10 +
>>  drivers/devfreq/Makefile        |   1 +
>>  drivers/devfreq/tegra-devfreq.c | 718 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 729 insertions(+)
>>  create mode 100644 drivers/devfreq/tegra-devfreq.c
>>
