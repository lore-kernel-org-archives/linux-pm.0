From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH RFC 03/27] PM / Domain: Add additional state specific param
Date: Thu, 19 Nov 2015 13:33:41 -0800
Message-ID: <7hpoz5u11m.fsf@deeprootsystems.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
	<1447799871-56374-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-4-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Tue, 17 Nov 2015 15:37:27 -0700")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Allow domain states to hold additional state related data in a u32
> value. This may be used by the platform driver.

Should probably expand the changelog here to give some examples how how
this might be used by the platform driver.

Kevin
