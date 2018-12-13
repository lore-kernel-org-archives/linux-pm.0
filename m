From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Date: Thu, 13 Dec 2018 15:44:17 +0530
Message-ID: <20181213101417.dcz66dpbqzbbxkdz@vireshk-i7>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
 <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
 <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
 <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 13-12-18, 02:12, Stephen Boyd wrote:
> It's on a v4.19 kernel with this cpufreq hw driver backported to it. I
> think all it takes is to return an error the second time the policy is
> initialized when cpufreq_online() calls into the cpufreq driver.

What do you mean by "the second time the policy is initialized" ?

We call cpufreq_online() only once for each policy.

-- 
viresh
