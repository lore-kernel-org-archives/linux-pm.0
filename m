From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Date: Mon, 21 May 2018 13:41:36 +0100
Message-ID: <20180521124136.GP17671@n2100.armlinux.org.uk>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526898690-4018-1-git-send-email-ilialin@codeaurora.org>
 <20180521105428.GM17671@n2100.armlinux.org.uk>
 <000b01d3f0f3$aa961cc0$ffc25640$@codeaurora.org>
 <20180521121140.GO17671@n2100.armlinux.org.uk>
 <000d01d3f100$294247e0$7bc6d7a0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000d01d3f100$294247e0$7bc6d7a0$@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ilialin@codeaurora.org
Cc: viresh.kumar@linaro.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 21, 2018 at 03:35:07PM +0300, ilialin@codeaurora.org wrote:
> There are 2 CPU clusters in the Kryo, CPU 0 and 1 are called Silver Cluster
> and CPU 2 and 3 - Gold Cluster. Each cluster has single clock. The clusters
> differ in terms of speed capabilities, computing power and power
> consumption. Therefore, I define separate OPP table for each cluster, and my
> driver will choose the appropriate OPP subset for each cluster.
> Lead refers to first CPU in the cluster.

Ah, that is really confusing.  Lead can means many things.  Maybe a
little more verbosity with the names such as SILVER_CLUSTER_LEAD_CPU
would help?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
