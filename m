From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] cpufreq: fix transition_ongoing count for powernow-k8
Date: Sat, 14 Sep 2013 01:42:19 +0200
Message-ID: <10372288.T6XyLE5FeS@vostro.rjw.lan>
References: <cover.1379062834.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379062834.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, September 13, 2013 06:29:37 PM Viresh Kumar wrote:
> This has been running in my mind since few days... That we have fixed cpufreq
> core and all other drivers for transition serialization but what about
> powernow-k8? It is somewhat special (even more than exynos5440).. It queues a
> work from ->target() and may or maynot send notifications at all..
> 
> Finally I have got a solution now (detailed logs in the patch)..
> These must go with following patchset:

The "must go" here is a totally wrong way of speaking about things, because I'm
not sure I'll take this patch series yet.

> https://lkml.org/lkml/2013/9/12/173

Thanks,
Rafael

