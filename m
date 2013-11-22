From: viresh kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] cpufreq: tegra: don't error target() when suspended
Date: Fri, 22 Nov 2013 10:29:31 +0530
Message-ID: <528EE4B3.2050102@linaro.org>
References: <1384981582-30697-1-git-send-email-swarren@wwwdotorg.org> <CAKohpomJiGbxk9BTJWcGRiid3TwV7d4i5BkSwSd8JxphSRZwUA@mail.gmail.com> <528E53C5.9040105@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <528E53C5.9040105-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Friday 22 November 2013 12:11 AM, Stephen Warren wrote:
> OK, sounds like I should ignore this issue then?

Yeah. And actually we are looking for a more generic solution instead o=
f these
per-driver PM notifiers. So, these should be removed soon..


https://lkml.org/lkml/2013/11/15/107=E2=80=8E
