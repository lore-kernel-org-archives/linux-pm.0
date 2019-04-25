From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Date: Thu, 25 Apr 2019 15:33:03 +0300
Message-ID: <20190425123303.GA12659@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com>
 <20190314121541.GB19385@apalos>
 <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
 <20190314134428.GA24768@apalos>
 <874l85v8p6.fsf@FE-laptop>
 <20190318112844.GA1708@apalos>
 <87h8c0s955.fsf@FE-laptop>
 <20190318122113.GA4834@apalos>
 <20190424093015.rcr5auamfccxf6ei@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424093015.rcr5auamfccxf6ei@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, Christian Neubert <christian.neubert.86@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@bootlin.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

> > > Also, during this week-end, Christian suggested that the issue might
> > > come from the AVS support.
> > > 
> > > Could you disable it and check you still have the issue?
> > > 
> > > For this, you just have to remove the avs node in
> > > arch/arm64/boot/dts/marvell/armada-37xx.dtsi and rebuild the dtb.
> > Sure. You'll have to wait for a week though. Currently on a trip. I'll run that
> >  once i return
> 
> @Ilias: Can you please try this now and confirm to Gregory ?
I am more overloaded than usual and totally forgot about this. Apologies.
I'll try finding some time and do this.

Thanks
/Ilias
