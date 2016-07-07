From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V6 1/2] cpufreq: Handle sorted frequency tables more efficiently
Date: Thu, 07 Jul 2016 15:29:27 +0200
Message-ID: <2145544.PRPhCeavDS@vostro.rjw.lan>
References: <594b312d352b55f44d5ebea954fdf784e966867e.1467001203.git.viresh.kumar@linaro.org> <6b89424cc08acf909f6ffc53d8028e5b7e5b23d0.1467023513.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57005 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751220AbcGGNYv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2016 09:24:51 -0400
In-Reply-To: <6b89424cc08acf909f6ffc53d8028e5b7e5b23d0.1467023513.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, francescolavra.fl@gmail.com

On Monday, June 27, 2016 04:04:07 PM Viresh Kumar wrote:
> cpufreq drivers aren't required to provide a sorted frequency table
> today, and even the ones which provide a sorted table aren't handled
> efficiently by cpufreq core.
> 
> This patch adds infrastructure to verify if the freq-table provided by
> the drivers is sorted or not, and use efficient helpers if they are
> sorted.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

