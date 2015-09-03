From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] cpufreq: dt: Minor fixes for 4.3
Date: Thu, 03 Sep 2015 03:14:52 +0200
Message-ID: <2477945.BNd713gtUN@vostro.rjw.lan>
References: <cover.1441184706.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41270 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755545AbbICArJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 20:47:09 -0400
In-Reply-To: <cover.1441184706.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Wednesday, September 02, 2015 02:36:47 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> These are minor fixes for cpufreq-dt driver.
> 
> --
> viresh
> 
> Viresh Kumar (3):
>   cpufreq: dt: Check OPP count before marking them shared
>   cpufreq: dt: Print error on failing to mark OPPs as shared
>   cpufreq: dt: Tolerance applies on both sides of target voltage
> 
>  drivers/cpufreq/cpufreq-dt.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)

I'm queuing this one up for the next PM pull request.

Thanks,
Rafael

