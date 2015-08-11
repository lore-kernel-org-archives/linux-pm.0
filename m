From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v8 04/13] clk: qcom: gdsc: Add support for ON only state
Date: Mon, 10 Aug 2015 23:59:37 -0700
Message-ID: <20150811065937.GF2839@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
 <1438857474-20262-5-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33341 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933501AbbHKG7j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 02:59:39 -0400
Content-Disposition: inline
In-Reply-To: <1438857474-20262-5-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org

On 08/06, Rajendra Nayak wrote:
> Certain devices can have GDSCs' which support ON as the only state.
> They can't be power collapsed to either hit RET or OFF.
> The clients drivers for these GDSCs' however would expect the state
> of the core to be reset following a GDSC disable and re-enable.
> To do this assert/deassert reset lines every time the client
> driver would request the GDSC to be powered on/off instead.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
