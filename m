From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Date: Mon, 10 Dec 2018 06:27:18 +0000
Message-ID: <20181210062718.GO26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
 <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
 <20181207192237.GK26661@dell>
 <20181208150526.uceviwfwqskfwovm@qschulz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181208150526.uceviwfwqskfwovm@qschulz>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Oskari Lemmela <oskari@lemmela.net>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, arm-linux <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 08 Dec 2018, Quentin Schulz wrote:

> Hi Lee,
> 
> On Fri, Dec 07, 2018 at 07:22:37PM +0000, Lee Jones wrote:
> > On Fri, 07 Dec 2018, Vasily Khoruzhick wrote:
> > 
> > > On Fri, Dec 7, 2018 at 8:40 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > 
> > > > My OCD-dar is going crazy.
> > > >
> > > > Why haven't you used the same alignment as is already there?
> > > >
> > > > If it starts to run over 80-chars then bring the others back.
> > > >
> > > > Also why is there a single liner shoved in the middle of the
> > > > multi-line entries?  Please move the singles to the top or the
> > > > bottom.
> > > 
> > > Hi Lee,
> > > 
> > > Could you please reformat it in the way that makes your OCD-dar happy?
> > > It would be really nice to get
> > 
> > I'm afraid not, for a multitude of reasons.
> > 
> > The most important of which surround testing.
> > 
> > > AC and battery support for APX8x3 merged -- it'll make Pinebook and
> > > Teres-I pretty well supported by mainline kernel.
> > 
> > That's great.  A worthy cause indeed.  So I'm sure you guys will want
> > to turn the patch around in short order so that it's applied in time
> > for the next merge window.
> > 
> 
> Aren't the MFD cells probed in order?
> 
> In that case, it makes little sense to short order them for this
> particular device (X-Powers PMICs in general). It will just make the
> system boot slower because of probe deferring.
> 
> Why? As explained by Chen-Yu in v3[1], axp-gpios can be muxed as
> regulators, thus should be probed before axp-regulators. axp-adc is
> often used by axp-battery, axp-usb-power, axp-ac-power, thus should be
> probed beforehand as well.

If there are inter-dependencies between the devices, it makes sense to
keep them in the most efficient order.

> For the alignment that also triggered your OCD, I can send you a patch
> the day you merge this one if it can help. I sent a few patches for this
> driver that didn't respect the alignment so I'm fine fixing the mfd
> cells (and eventually re-order them as I saw a few axp-gpio cells being
> declared after axp-regulators).

That's fine.  Please send the patch (based on this set) right away.

> Does that make this patch OK for you, Lee?

Yes, thank you.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
