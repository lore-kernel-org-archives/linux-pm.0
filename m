From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v7 01/13] clk: qcom: Add support for GDSCs
Date: Wed, 05 Aug 2015 11:01:16 +0530
Message-ID: <55C19FA4.4070402@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org> <1438076046-4706-2-git-send-email-rnayak@codeaurora.org> <20150803192427.GA7096@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150803192427.GA7096@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, mturquette@baylibre.com, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 08/04/2015 12:54 AM, Stephen Boyd wrote:
> On 07/28, Rajendra Nayak wrote:
>> +
>> +#define PWR_ON_MASK		BIT(31)
>> +#define EN_REST_WAIT_MASK	GENMASK(23, 20)
>> +#define EN_FEW_WAIT_MASK	GENMASK(19, 16)
>> +#define CLK_DIS_WAIT_MASK	GENMASK(15, 12)
>
> This trips up some static checker...
>
> drivers/clk/qcom/gdsc.c:234:53: warning: cast truncates bits from
> constant value (fffffffffff006 becomes fffff006)
>
> So I think we can use GENMASK_ULL here instead.

Sure. btw, what static checker is this? I did not see it with sparse.
