From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 144/228] cpufreq: sa11x0: use cpufreq_generic_init()
	routine
Date: Fri, 13 Sep 2013 15:32:26 +0100
Message-ID: <20130913143226.GX12758@n2100.arm.linux.org.uk>
References: <cover.1379063063.git.viresh.kumar@linaro.org> <254e7e912c3817fdf1499bb1ea7be7bc7f3cdbef.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54615 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987Ab3IMOce (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 10:32:34 -0400
Content-Disposition: inline
In-Reply-To: <254e7e912c3817fdf1499bb1ea7be7bc7f3cdbef.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 13, 2013 at 06:31:30PM +0530, Viresh Kumar wrote:
> Use generic cpufreq_generic_init() routine instead of replicating the same code
> here.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
