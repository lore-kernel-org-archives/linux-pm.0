From: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] Add Mediatek MT8173 cpufreq driver
Date: Tue, 9 Jun 2015 08:26:11 +0800
Message-ID: <CALx668XYaKca3BeYQxgNa2z68x7w8iTg8hyeeYdLtpJYc30idw@mail.gmail.com>
References: <1433766561-1330-1-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433766561-1330-1-git-send-email-pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "pi-cheng.chen" <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 8, 2015 at 8:29 PM, Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> MT8173 is a ARMv8 based SoC with 2 clusters. All CPUs in a single cluster
> share the same power and clock domain. This series tries to add cpufreq support
> for MT8173 SoC.

I am sorry I forgot to add the version in the mail title.
This is v4 of this series.

>
> Changes in v4:
> - Add bindings for MT8173 cpufreq driver
> - Move OPP table back into device tree
> - Address comments for last version
>
> Changes in v3:
> - Implement MT8173 specific standalone cpufreq driver instead of using
>   cpufreq-dt driver
> - Define OPP table in the driver source code until new OPP binding is ready
>
> Changes in v2:
> - Add intermediate frequency support in cpufreq-dt driver
> - Use voltage scaling code of cpufreq-dt for little cluster instead of
>   implementaion in notifier of mtk-cpufreq driver
> - Code refinement for mtk-cpufreq driver
>
> Pi-Cheng Chen (2):
>   dt-bindings: mediatek: Add MT8173 cpufreq driver binding
>   cpufreq: mediatek: Add MT8173 cpufreq driver
>
>  .../devicetree/bindings/cpufreq/cpufreq-mt8173.txt | 127 +++++
>  drivers/cpufreq/Kconfig.arm                        |   7 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/mt8173-cpufreq.c                   | 550 +++++++++++++++++++++
>  4 files changed, 685 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
>  create mode 100644 drivers/cpufreq/mt8173-cpufreq.c
>
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
