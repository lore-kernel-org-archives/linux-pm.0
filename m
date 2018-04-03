From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 13/14] dt-bindings: cpufreq: Document
 operating-points-v2-kryo-cpu
Date: Tue, 3 Apr 2018 09:53:41 +0530
Message-ID: <20180403042341.GI3572@vireshk-i7>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-14-git-send-email-ilialin@codeaurora.org>
 <20180402093018.GC3572@vireshk-i7>
 <7ca35b7a-6078-620b-4772-091e53ef6790@codeaurora.org>
 <06308b25-14ea-8d8b-6f95-f05c101a617b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <06308b25-14ea-8d8b-6f95-f05c101a617b@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: Ilia Lin <ilialin@codeaurora.org>, mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org, amit.kucheria@linaro.org, nicolas.dechesne@linaro.org, celster@codeaurora.org, tfinkel@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 03-04-18, 08:11, Sricharan R wrote:
>  Right, i was adding a similar one for krait cores [1]. There is code common in the
>  init sequence across both (little). Do you suggest to make them common ?

It may make sense as we are talking about one SoC family here :)

-- 
viresh
