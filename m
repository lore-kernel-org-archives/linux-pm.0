From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 2/2] PM / devfreq: Generic cpufreq governor
Date: Mon, 28 May 2018 15:00:14 +0900
Message-ID: <20180528060014epcms1p87ec68a4d44f9447b06f979a87e545b7d@epcms1p8>
References: <1526631889-5084-3-git-send-email-skannan@codeaurora.org>
        <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
        <CGME20180518082505epcas2p265038f51fc070a4aada4c692a71ebc3c@epcms1p8>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526631889-5084-3-git-send-email-skannan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Saravana Kannan <skannan@codeaurora.org>, Rajendra Nayak <rjendra@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>Many CPU architectures have caches that can scale independent of the CPUs.
>Frequency scaling of the caches is necessary to make sure the cache is not
>a performance bottleneck that leads to poor performance and power. The same
>idea applies for RAM/DDR.
>
>To achieve this, this patch series adds a generic devfreq governor that can
>listen to the frequency transitions of each CPU frequency domain and then
>adjusts the frequency of the cache (or any devfreq device) based on the
>frequency of the CPUs.

I agree that we have some hardware pieces that want to configure
frequencies based on the CPUfreq.

Creating a devfreq governor that configures devfreq-freq
based on incoming events (CPUFreq-transition-event in this case)
is indeed a good idea.

However, I would like to ask the followings:
The overall code appears to be overly complex compared what you need.
- Do you really need to revive "CPUFREQ POLICY" events for this?
especially when you are going to look at "first CPU" only?


Cheers,
MyungJoo
