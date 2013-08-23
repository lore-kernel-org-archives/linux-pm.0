From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] cpufreq: tegra: fix the wrong clock name
Date: Fri, 23 Aug 2013 10:23:21 +0530
Message-ID: <CAKohpoki3wG=S8AU4v2LTk7NTLNS+BU_Yz5O+LTQTcdehciUbg@mail.gmail.com>
References: <1377222238-9439-1-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377222238-9439-1-git-send-email-josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 23 August 2013 07:13, Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> The "cpu" and "pclk_p_cclk" was a virtual clock name that was used in
> the legacy Tegra clock framework. It was not used after converting to
> CCF. Fix it as the correct clock name that we are using.
>
> Signed-off-by: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/cpufreq/tegra-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to cpufreq-fixes. Thanks.
