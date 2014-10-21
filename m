From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: qoriq: Make the driver usable on all QorIQ platforms
Date: Tue, 21 Oct 2014 14:33:31 +0530
Message-ID: <CAKohpokSuKOwZ3-OWFtU0z7E1fsMg4tyPiUoFUfw26pD9Py=MA@mail.gmail.com>
References: <1413515616-15874-1-git-send-email-B29983@freescale.com>
	<CAKohpokotKSvQ13uU4MnCer+qzBUUbGVTd19y7xswCAEKk3nGQ@mail.gmail.com>
	<6aaa50ef5f234fe2896f1c66eb646dfb@DM2PR03MB574.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6aaa50ef5f234fe2896f1c66eb646dfb@DM2PR03MB574.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: linux-pm@vger.kernel.org

On 21 October 2014 14:29, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> If I do so, menuconfig will display like this(on PPC):
>         PowerPC CPU frequency scaling drivers  ----
>     QorIQ CPU Frequency scaling  --->
>                 <*> CPU frequency scaling driver for Freescale QorIQ SoCs
> On ARM, there should be a similar problem.
> Isn't weird?

Similar is true for cpufreq-cpu0 driver as well.. Maybe we can create a
Kconfig.drivers configuration and include it from all architecture specific
ones ?

@ Rafael ?
