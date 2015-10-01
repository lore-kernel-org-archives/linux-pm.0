From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] arm: dts: qcom: Add #power-domain-cells property
Date: Thu, 1 Oct 2015 10:36:30 -0700
Message-ID: <20151001173630.GC19319@codeaurora.org>
References: <1443691562-16963-1-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443691562-16963-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/01, Rajendra Nayak wrote:
> clock controller nodes which also support power domains (gdscs') need
> to have a #power-domain-cells property. Add these for gcc and mmcc
> nodes of msm8974, gcc of apq8084 and msm8916.
> Also update gcc and mmcc bindings for it.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
