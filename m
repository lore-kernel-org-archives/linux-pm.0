From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Tue, 19 Jun 2018 11:19:47 +0530
Message-ID: <20180619054947.5u5gpallmtzkilor@vireshk-i7>
References: <1529054393-27077-1-git-send-email-daniel.lezcano@linaro.org>
 <20180618102245.x5cfei3i7voq65zc@vireshk-i7>
 <bb11af50-1089-43af-abfa-0824e0db1e77@linaro.org>
 <20180618103844.t2minxwc7tiu2qgd@vireshk-i7>
 <883320cc-5677-6612-1565-b5a05b8684e1@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <883320cc-5677-6612-1565-b5a05b8684e1@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-pm@vger.kernel.org

On 18-06-18, 13:28, Daniel Lezcano wrote:
> for this specific case, we can use the park() callback to set should_run
> to false, no ?

Yep, that can be one option. Or just iterate through all the CPUs in the mask.

-- 
viresh
