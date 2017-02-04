From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 4/5] soc: samsung: pm_domains: Read domain name from
 the new label property
Date: Sat, 4 Feb 2017 17:46:57 +0200
Message-ID: <20170204154657.c4pts6wppsq3wmf2@kozik-lap>
References: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130121915eucas1p23aa4f4be912bcd64f9521f6e6b51132f@eucas1p2.samsung.com>
 <1485778740-30337-5-git-send-email-m.szyprowski@samsung.com>
 <20170201162554.airhzowkqpyaxqpf@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170201162554.airhzowkqpyaxqpf@rob-hp-laptop>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 01, 2017 at 10:25:54AM -0600, Rob Herring wrote:
> On Mon, Jan 30, 2017 at 01:18:59PM +0100, Marek Szyprowski wrote:
> > Device tree nodes for each power domain should use generic "power-domain"
> > name, so using it as a domain name doesn't give much benefits. This patch
> > adds support for human readable names defined in 'label' property. Such
> > names are visible to userspace and makes debugging much easier. When no
> > 'label' property is found, driver keeps using the name constructed from
> > full node name.
> 
> I'm not sure this is really a good use of label. label is intended for 
> end user visible things like ports/connectors on a board. It's fine 
> here, but I wouldn't want to see it used everywhere.
>

Thanks for comments. We want to use the label here for user visible
output - through dmesg or debugfs. Otherwise, we would have to stick
(always) to more descriptive node names, like "lcd-power-domain@xxxxx".

Best regards,
Krzysztof
