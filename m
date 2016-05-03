From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Tue, 3 May 2016 12:25:51 +0200
Message-ID: <20160503102551.GC3956@kozik-lap>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 11, 2016 at 12:57:38PM +0900, Chanwoo Choi wrote:
> This patch-set includes the two features as following. The generic exynos bus
> frequency driver is able to support almost Exynos SoCs for bus frequency
> scaling. And the new passive governor is able to make the dependency on
> between devices for frequency/voltage scaling. I had posted the patch-set[1]
> with the similiar concept. This is is revised version for exynos bus frequency.
> - Generic exynos bus frequency driver
> - New passive governor of DEVFREQ framework
> [1] https://lkml.org/lkml/2015/1/7/872
> : [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency driver

Applied DTS patches for late v4.7 (hopefully).

Best regards,
Krzysztof
