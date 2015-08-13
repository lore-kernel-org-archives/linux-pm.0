From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v8 10/13] arm: dts: qcom: Add #power-domain-cells property
Date: Thu, 13 Aug 2015 09:54:23 +0530
Message-ID: <55CC1BF7.1040406@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org> <1438857474-20262-11-git-send-email-rnayak@codeaurora.org> <20150811065335.GB2839@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47477 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbbHMEY3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 00:24:29 -0400
In-Reply-To: <20150811065335.GB2839@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org

On 08/11/2015 12:23 PM, Stephen Boyd wrote:
> On 08/06, Rajendra Nayak wrote:
>> msm8974 has gcc and mmcc nodes, and apq8084 has a gcc node which
>> implement gdsc powerdomains. Add the #power-domain-cells property
>> to them.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>
> This needs to go through  Andy's tree and arm-soc. Also, I don't
> see an update for the binding anywhere. Please update the binding
> too.

Will do, I hope you mean update the bindings in qcom,mmcc.txt and
qcom,gcc.txt?
