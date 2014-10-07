From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 04/15] clk: divider: Make generic for usage elsewhere
Date: Tue, 07 Oct 2014 20:28:16 +0100
Message-ID: <54343ED0.6070200@linaro.org>
References: <1409957256-23729-1-git-send-email-sboyd@codeaurora.org> <1409957256-23729-5-git-send-email-sboyd@codeaurora.org> <542EE5FE.9080806@codeaurora.org> <54342287.7020005@linaro.org> <54343038.2060007@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54343038.2060007@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 07/10/14 19:26, Stephen Boyd wrote:
> On 10/07/2014 10:27 AM, Srinivas Kandagatla wrote:
>> Hi Stephen,
>>
>> Just noticed this regression while testing the patch on Arndale board.
>>
>> https://bugs.linaro.org/show_bug.cgi?id=740
>
> If you return value it works correctly right?
>
Am really not sure, as this bug was originally reported as part of 
Linaro tracking kernel.

--srini
