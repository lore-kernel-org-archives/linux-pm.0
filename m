From: dawei chien <dawei.chien@mediatek.com>
Subject: Re: [PATCH v5 2/3] arm64: dts: mt8173: Add thermal zone node.
Date: Wed, 16 Dec 2015 18:09:13 +0800
Message-ID: <1450260553.7981.14.camel@mtksdaap41>
References: <1450238356-36319-1-git-send-email-dawei.chien@mediatek.com>
	 <1450238356-36319-3-git-send-email-dawei.chien@mediatek.com>
	 <CAGS+omDDfJb9dfWWPaMKs=MkO4Pf3RF9SUD==i7sgHsrDhFDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGS+omDDfJb9dfWWPaMKs=MkO4Pf3RF9SUD==i7sgHsrDhFDxA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2015-12-16 at 16:34 +0800, Daniel Kurtz wrote:
> On Wed, Dec 16, 2015 at 11:59 AM, Dawei Chien <dawei.chien@mediatek.com> wrote:
> >
> > This adds thermal zone node to Mediatek MT8173 dtsi file.
> >
> > Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> > ---
> > This patch is base on patchset:
> > https://lkml.org/lkml/2015/11/30/239
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   43 ++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index fda805d..4114cee 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -188,6 +188,49 @@
> >                 clock-output-names = "cpum_ck";
> >         };
> >
> > +       thermal-zones {
> > +               cpu_thermal: cpu_thermal {
> > +                       polling-delay-passive = <1000>; /* milliseconds */
> > +                       polling-delay = <1000>; /* milliseconds */
> > +
> > +                       thermal-sensors = <&thermal 0>;
> 
> This should be <&thermal> with the MTK temp sensor node in
> https://lkml.org/lkml/2015/11/30/239 patch series.
> 
> -Dan

Hi Dan,
Sascha's thermal driver V12 only register sensor id as 0, so we need to
register sensor id as 0 to device tree as well.

Either <&thermal 0> or <&thermal>, sensor id should be 0 for two cases.
I try this two case, function all work fine for two cases. May I have
any misunderstand? Please kindly give your comment.
I will re-send this patch again once you tell me the reason, thank you.

BR,
Dawei
