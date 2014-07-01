From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/2] cpuidle fixes and cleanup
Date: Tue, 1 Jul 2014 15:52:44 +0100
Message-ID: <20140701145244.GX32514@n2100.arm.linux.org.uk>
References: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <k.chander@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 01, 2014 at 08:02:36PM +0530, Chander Kashyap wrote:
> This patch series fixes the cpuidle for different states. Also removes arm
> diagnostic and power register save/restore code as it is made generic.
> 
> Based on:
> ARM: save/restore diagnostic register on Cortex-A9 suspend/resume
>  http://www.spinics.net/lists/arm-kernel/msg340506.html

As there is an outstanding issue with this patch, we can't proceed with
this set of changes until we know what's going on there.

Also, bear in mind that I have changes which conflict with this in my
tree (which I've just updated.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
