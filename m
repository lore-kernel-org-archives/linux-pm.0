From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Mon, 11 Apr 2016 21:55:57 +0200
Message-ID: <20160411195557.GA6426@kozik-lap>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <570B218E.5000908@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570B218E.5000908@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, kyungmin.park@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 11, 2016 at 01:01:18PM +0900, Chanwoo Choi wrote:
> Dear Myungjoo and Krzysztof,
> 
> This patch-set already get the acked-by or signed-off-by tag
> from Exynos SoC and DEVFREQ maintainer except for patch10.
> 
> If there is no comment, could you pick this patch-set?

I cannot find any description of dependencies between the patches so I
assume the obvious one: DTS patches do not depend on anything. This
means that:
1. driver/devfreq related changes (including dt-bindings documentation)
   go to Myungjoo,
2. I can pick DTS changes.

But first I would like to see the bindings documentation beeing applied
by someone as a proof that there won't be more development in DTS in
these series. There is no sense of picking DTS if after comments from
Rob, you will rework them, right?

Anyway I see Rob's questions. For these bindings I think you should get
DT-guys ack first.

Best regards,
Krzysztof
