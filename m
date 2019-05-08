From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v7 07/13] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
Date: Wed, 8 May 2019 09:19:40 +0200
Message-ID: <CAJKOXPdacKBrKeCyCaE7VS8-NOR4Oo27XY7rx20P2ORY2vBBSg@mail.gmail.com>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc@eucas1p2.samsung.com>
 <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com> <20190507170422.GA25179@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507170422.GA25179@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, kgene@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, 7 May 2019 at 19:04, Rob Herring <robh@kernel.org> wrote:
> > +- devfreq-events : phandles of the PPMU events used by the controller.
> > +- samsung,syscon-chipid : phandle of the ChipID used by the controller.
> > +- samsung,syscon-clk : phandle of the clock register set used by the controller.
>
> Looks like a hack. Can't you get this from the clocks property? What is
> this for?

Hi Rob,

Lukasz uses these two syscon regmaps to read certain registers. For
chipid he reads it to check the size of attached memory (only 2 GB
version is supported). This indeed looks like a hack. However the
second regmap (clk) is needed to get the timing data from registers
from DMC clock driver address space. These are registers with memory
timing so their data is not exposed anyway in common clk framework.

Best regards,
Krzysztof
