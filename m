From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 5/7] clk: samsung: exynos542x: Add the clock id for ACLK
Date: Tue, 12 Apr 2016 13:25:10 +0200
Message-ID: <570CDB16.2050001@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-6-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1460091646-28701-6-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
> This patch adds the clock id for ACLK clock which is source clock of AMBA AXI
> Bus. This clock should be handled in Bus frequency scaling driver.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 85 +++++++++++++++++++++++-------------
>  1 file changed, 55 insertions(+), 30 deletions(-)

The IDs itself look good but you are not adding only clock ID. You are
changing all of them from NULL-flags to CLK_SET_RATE_PARENT. This should
be explained in the commit message why you need it. Probably it should
be also in separate commit.

Best regards,
Krzysztof
