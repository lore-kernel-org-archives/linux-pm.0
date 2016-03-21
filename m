From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [RFC v3 11/12] ARM64: dts: Add PSCI cpuidle support for MSM8916
Date: Sun, 20 Mar 2016 22:50:43 -0500
Message-ID: <20160321034639.GA3106@hector.attlocal.net>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
 <1456866931-37851-13-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456866931-37851-13-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 01, 2016 at 02:15:30PM -0700, Lina Iyer wrote:
> Add device bindings for CPUs to suspend using PSCI as the enable-method.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Works great.  All CPUs functional and I saw SPC idle states incrementing.

Tested-by: Andy Gross <andy.gross@linaro.org>
