From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Date: Thu, 13 Dec 2018 16:06:08 +0530
Message-ID: <20181213103608.vs255cq46fu4w2cc@vireshk-i7>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
 <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
 <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
 <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
 <20181213101417.dcz66dpbqzbbxkdz@vireshk-i7>
 <154469713309.19322.12951478077195078609@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154469713309.19322.12951478077195078609@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 13-12-18, 02:32, Stephen Boyd wrote:
> I have one policy for four CPUs. So take down all four of those CPUs by
> writing a 0 to the online file for each CPU, and then bring them back
> online. That should make cpufreq_driver->init() be called twice, once
> during boot when the CPUs are bound to the cpufreq devices, and second
> from the sysfs write when the user brings the first CPU in that policy
> online again by writing a 1 to the online file. If that second time it
> fails I suspect we hit the lockdep warning.

Okay, that is a special sequence. I will try to reproduce that
locally. Thanks.

-- 
viresh
