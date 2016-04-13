From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 5/7] clk: samsung: exynos542x: Add the clock id for ACLK
Date: Wed, 13 Apr 2016 09:20:41 +0300
Message-ID: <CA+Ln22EFdspBdHwWar65UZ-uFxq4c9+RPhNCJjgKp9idvDvM5A@mail.gmail.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
	<1460091646-28701-6-git-send-email-cw00.choi@samsung.com>
	<570CDB16.2050001@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f65.google.com ([209.85.192.65]:35404 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933834AbcDMGUn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 02:20:43 -0400
In-Reply-To: <570CDB16.2050001@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux.amoon@gmail.com, m.reichl@fivetechno.de, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, InKi Dae <inki.dae@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

2016-04-12 14:25 GMT+03:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
>> This patch adds the clock id for ACLK clock which is source clock of AMBA AXI
>> Bus. This clock should be handled in Bus frequency scaling driver.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5420.c | 85 +++++++++++++++++++++++-------------
>>  1 file changed, 55 insertions(+), 30 deletions(-)
>
> The IDs itself look good but you are not adding only clock ID. You are
> changing all of them from NULL-flags to CLK_SET_RATE_PARENT. This should
> be explained in the commit message why you need it. Probably it should
> be also in separate commit.

+1. And CLK_SET_RATE_PARENT for a clock which has a mux as its parent
is a bit suspicious, so I'd like to know the rationale for each single
clock with CLK_SET_RATE_PARENT being added.

Best regards,
Tomasz
