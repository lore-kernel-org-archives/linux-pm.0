From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] cpuidle: mvebu: update cpuidle thresholds for Armada
 XP SOCs
Date: Tue, 24 Feb 2015 18:36:03 +0100
Message-ID: <54ECB683.6060705@free-electrons.com>
References: <alpine.LNX.2.02.1502131534360.8729@sbrk.sbrk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40833 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751605AbbBXRgJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 12:36:09 -0500
In-Reply-To: <alpine.LNX.2.02.1502131534360.8729@sbrk.sbrk.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "s. rannou" <mxs@sbrk.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Sebastien,

On 13/02/2015 15:55, s. rannou wrote:
> Originally, the thresholds used in the cpuidle driver for Armada SOCs
> were temporarily chosen, leaving room for improvements.
> 
> This commit updates the thresholds for the Armada XP SOCs with values
> that positively impact performances:
> 
>                                 without patch  with patch   vendor kernel
>  - iperf localhost (gbit/sec)   ~3.7           ~6.4         ~5.4
>  - ioping tmpfs (iops)          ~163k          ~206k        ~179k
>  - ioping tmpfs (mib/s)         ~636           ~805         ~699
> 
> The idle power consumption is negatively impacted (proportionally less
> than the performance gain), and we are still performing better than
> the vendor kernel here:
> 
>                                 without patch   with patch  vendor kernel
>  - power consumption idle (W)   ~2.4            ~3.2        ~4.4
>  - power consumption busy (W)   ~8.6            ~8.3        ~8.6
> 
> There is still room for improvement regarding the value of these
> thresholds, they were chosen to mimic the vendor kernel.
> 
> This patch only impacts Armada XP SOCs and was tested on Online Labs
> C1 boards. A similar approach can be taken to improve the performances
> of the Armada 370 and Armada 38x SOCs.
> 
> Thanks a lot to Thomas Petazzoni, Gregory Clement and Willy Tarreau
> for the discussions and tips around this topic.

Thanks for your work and all the test you have done. As you mentioned
there should be still room for improvement, but this patch is already
a step in the good direction. So you can add my:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

While this driver is related to mvebu SoCs, it is not part of the mvebu subsystem
but of the PM subsystem and should be taken by its maintainers. I added them
in copy as well as the pm list.

Daniel and Rafael,
if you didn't get the original email I can bounced if needed. I also wonder
it it would worth applying it on the stable branch. What do you think about it?

Thanks,

Gregory



> 
> Signed-off-by: Sebastien Rannou <mxs@sbrk.org>
> ---
>  drivers/cpuidle/cpuidle-mvebu-v7.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
> index 38e6861..3716a1f 100644
> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
> @@ -50,17 +50,17 @@ static struct cpuidle_driver armadaxp_idle_driver = {
>  	.states[0]		= ARM_CPUIDLE_WFI_STATE,
>  	.states[1]		= {
>  		.enter			= mvebu_v7_enter_idle,
> -		.exit_latency		= 10,
> +		.exit_latency		= 100,
>  		.power_usage		= 50,
> -		.target_residency	= 100,
> +		.target_residency	= 1000,
>  		.name			= "MV CPU IDLE",
>  		.desc			= "CPU power down",
>  	},
>  	.states[2]		= {
>  		.enter			= mvebu_v7_enter_idle,
> -		.exit_latency		= 100,
> +		.exit_latency		= 1000,
>  		.power_usage		= 5,
> -		.target_residency	= 1000,
> +		.target_residency	= 10000,
>  		.flags			= MVEBU_V7_FLAG_DEEP_IDLE,
>  		.name			= "MV CPU DEEP IDLE",
>  		.desc			= "CPU and L2 Fabric power down",
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
