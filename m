From: Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [v9,04/15] clk: qcom: Add HFPLL driver
Date: Sun, 25 Mar 2018 20:33:41 +0100
Message-ID: <20180325193341.27845-1-ctatlor97@gmail.com>
References: <520347148-27852-5-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <520347148-27852-5-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk
List-Id: linux-pm@vger.kernel.org

This doesn't seem to work correctly with the higher clocks on 8974pro, specifically 2150400000 hz or above, maybe its something to do with being bigger than an unsigned long.

When i try to set any higher frequency it jumps down to 300mhz.
