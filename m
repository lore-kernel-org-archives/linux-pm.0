From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Documentation: Fix opp-microvolt in examples
Date: Fri, 3 Mar 2017 09:28:05 -0800
Message-ID: <756a9b97-ba24-4cc2-7236-b3bd94d74f6f@codeaurora.org>
References: <e527318dc8b5a1acf260499c65cf025732d9fc51.1488365712.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdCCR2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2017 12:28:10 -0500
In-Reply-To: <e527318dc8b5a1acf260499c65cf025732d9fc51.1488365712.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org

On 03/01/2017 03:09 AM, Viresh Kumar wrote:
> The triplet present in "opp-microvolt" property should be in the order
> <target min max>, while all the examples have it in the order
> <min target max>.
>
> Fix it.
>
> Luckily all of the users of "opp-microvolt" property have applied brain
> instead of copying the examples from documentation and none of the
> actual dts files have it wrong.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Did you want a fixes tag too? Sure it's just documentation.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
