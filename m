From: Andy Gross <agross@codeaurora.org>
Subject: Re: [PATCH v16 00/11] ARM: qcom: cpuidle support for 8064, 8074, 8084
Date: Wed, 18 Mar 2015 01:05:10 -0500
Message-ID: <20150318060510.GA15705@qualcomm.com>
References: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 17, 2015 at 04:33:40PM -0600, Lina Iyer wrote:

<snip>

> 
> Tested on: 8074, 8084.
> 

These worked fine for me on IPQ8064 (ap148), however I did have to add my own DT
entries for the idle states and saw changes.

Also tested on APQ8064 (ifc6410).

Tested-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
