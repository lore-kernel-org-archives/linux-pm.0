From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: Make oxili GDSC parent of oxili_cx
 GDSC
Date: Fri, 13 Nov 2015 09:49:22 +0530
Message-ID: <564564CA.5040608@codeaurora.org>
References: <1443727374-1539-1-git-send-email-sboyd@codeaurora.org> <1443727374-1539-3-git-send-email-sboyd@codeaurora.org> <20151006193217.GH12338@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151006193217.GH12338@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Rob Clark <robdclark@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org


On 10/07/2015 01:02 AM, Stephen Boyd wrote:
> On 10/01, Stephen Boyd wrote:
>> The oxili_cx GDSC is inside the power domain of the oxili GDSC.
>> Add the dependency so that the CX domain can properly power up.
>>
>> Reported-by: Rob Clark <robdclark@gmail.com>
>> Cc: Rajendra Nayak <rnayak@codeaurora.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
> 
> Applied to clk-next

I don't see this in clk-next. Was this dropped for some reason?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
