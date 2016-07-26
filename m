From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 00/14] PM: SoC idle support using PM domains
Date: Tue, 26 Jul 2016 15:08:49 -0700
Message-ID: <m260rsuk5q.fsf@baylibre.com>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Wed, 22 Jun 2016 13:36:35 -0600")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Hi all,
>
> Changes since RFC-v3:
> - Reorganize the patches. Documentations have their own patch.
> - Moved code around with PSCI OS initiated so they would not have compiler
>   errors in other configuration.
> - Minor bug fixes with genpd power_on functionality.
> - Rebased on top of 4.7-rc1

This is looking good.  I've had a quick look through this, as well as
tested it on apq8016-sbc (dragon 410c.)

Seems the main thing left to resolve is the DT description.

Kevin
