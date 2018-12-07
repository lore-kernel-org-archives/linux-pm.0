From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Date: Fri, 7 Dec 2018 19:22:37 +0000
Message-ID: <20181207192237.GK26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
 <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Oskari Lemmela <oskari@lemmela.net>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, quentin.schulz@bootlin.com, linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, arm-linux <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 07 Dec 2018, Vasily Khoruzhick wrote:

> On Fri, Dec 7, 2018 at 8:40 AM Lee Jones <lee.jones@linaro.org> wrote:
> 
> > My OCD-dar is going crazy.
> >
> > Why haven't you used the same alignment as is already there?
> >
> > If it starts to run over 80-chars then bring the others back.
> >
> > Also why is there a single liner shoved in the middle of the
> > multi-line entries?  Please move the singles to the top or the
> > bottom.
> 
> Hi Lee,
> 
> Could you please reformat it in the way that makes your OCD-dar happy?
> It would be really nice to get

I'm afraid not, for a multitude of reasons.

The most important of which surround testing.

> AC and battery support for APX8x3 merged -- it'll make Pinebook and
> Teres-I pretty well supported by mainline kernel.

That's great.  A worthy cause indeed.  So I'm sure you guys will want
to turn the patch around in short order so that it's applied in time
for the next merge window.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
