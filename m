From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 1/8] PM / devfreq: event: Add new Exynos NoC probe driver
Date: Fri, 15 Apr 2016 10:37:26 +0200
Message-ID: <5710A846.1020304@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
 <1460701975-24178-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1460701975-24178-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, tomasz.figa@gmail.com, s.nawrocki@samsung.com, kgene@kernel.org
Cc: robh@kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/15/2016 08:32 AM, Chanwoo Choi wrote:
> This patch adds NoC (Network on Chip) Probe driver which provides
> the primitive values to get the performance data. The packets that the Network
> on Chip (NoC) probes detects are transported over the network infrastructure.
> Exynos542x bus has multiple NoC probes to provide bandwidth information about
> behavior of the SoC that you can use while analyzing system performance.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  .../bindings/devfreq/event/exynos-nocp.txt         |  26 ++
>  drivers/devfreq/event/Kconfig                      |   8 +
>  drivers/devfreq/event/Makefile                     |   2 +
>  drivers/devfreq/event/exynos-nocp.c                | 304 +++++++++++++++++++++
>  drivers/devfreq/event/exynos-nocp.h                |  78 ++++++
>  5 files changed, 418 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-nocp.txt
>  create mode 100644 drivers/devfreq/event/exynos-nocp.c
>  create mode 100644 drivers/devfreq/event/exynos-nocp.h
> 

Looks good now.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
