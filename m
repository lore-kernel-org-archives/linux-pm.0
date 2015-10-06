From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: Make oxili GDSC parent of oxili_cx GDSC
Date: Tue, 6 Oct 2015 12:32:17 -0700
Message-ID: <20151006193217.GH12338@codeaurora.org>
References: <1443727374-1539-1-git-send-email-sboyd@codeaurora.org>
 <1443727374-1539-3-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443727374-1539-3-git-send-email-sboyd@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Mike Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Rob Clark <robdclark@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 10/01, Stephen Boyd wrote:
> The oxili_cx GDSC is inside the power domain of the oxili GDSC.
> Add the dependency so that the CX domain can properly power up.
> 
> Reported-by: Rob Clark <robdclark@gmail.com>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
