From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization
Date: Fri, 29 Mar 2013 17:01:43 +0530
Message-ID: <51557B9F.7090608@ti.com>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org> <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org> <51556F1D.5030208@ti.com> <515570DF.5010608@linaro.org> <515572C7.1030309@ti.com> <515579C6.1090602@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <515579C6.1090602-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: rjw-KKrjLPT3xs0@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Friday 29 March 2013 04:53 PM, Daniel Lezcano wrote:
> On 03/29/2013 11:53 AM, Santosh Shilimkar wrote:
>> On Friday 29 March 2013 04:15 PM, Daniel Lezcano wrote:
[..]

> For OMAP3 that could be a bit more difficult. Who is maintaining the
> driver now ?
> 
The driver is still maintained by Kevin Hilman and quite a few us keep
that driver upto date. OMAP3 idle is movable as well. A while back I
have assessed move of OMAP3 and OMAP4 idle drivers, and the only issue
was the other PRM/CM dependency.

Regards,
Santosh
