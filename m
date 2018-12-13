From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Date: Thu, 13 Dec 2018 15:35:06 +0530
Message-ID: <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
 <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 13-12-18, 01:58, Stephen Boyd wrote:
> BTW, Viresh, I see a lockdep splat when cpufreq_init returns an error
> upon bringing the policy online the second time. I guess cpufreq_stats
> aren't able to be freed from there because they take locks in different
> order vs. the normal path?

Please share the lockdep report and the steps to reproduce it. I will
see if I can simulate the failure forcefully..

-- 
viresh
