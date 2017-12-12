From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v1 4/4] arm64: dts: mediatek: add mt2712 cpufreq related device nodes
Date: Tue, 12 Dec 2017 02:17:06 +0100
Message-ID: <1758225.tOgn8eUOoH@aspire.rjw.lan>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com> <1512713278-17807-5-git-send-email-andrew-sh.cheng@mediatek.com> <20171211075719.GD25177@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171211075719.GD25177@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew-sh Cheng <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Monday, December 11, 2017 8:57:19 AM CET Viresh Kumar wrote:
> On 08-12-17, 14:07, Andrew-sh Cheng wrote:
> > Add opp v2 information,
> > and also add clocks, regulators and opp information into cpu nodes
> > 
> > Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 27 ++++++++++++++
> >  arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 57 +++++++++++++++++++++++++++++
> >  2 files changed, 84 insertions(+)
> 
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Of course, DT bindings require ACKs from DT maintainers to be applied.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
