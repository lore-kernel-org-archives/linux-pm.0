From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: mvebu: Fix the name of the states
Date: Thu, 19 Jun 2014 01:32:59 +0200
Message-ID: <2630012.Dan7hg1t0j@vostro.rjw.lan>
References: <1403095063-22843-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63149 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753354AbaFRXPY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jun 2014 19:15:24 -0400
In-Reply-To: <1403095063-22843-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Wednesday, June 18, 2014 02:37:43 PM Gregory CLEMENT wrote:
> The length name of the states 2 was too long to fit in the allocated
> string (limited to 16 bytes). This lead to improper string displayed
> through sysfs.
> 
> This patch shorten the name by removing the reference to Marvell and
> to the CPU as both are implicit. For coherency the same change have
> been done for the states 1.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi,
> 
> This fix should be merged in 3.16.

Applied, thanks!

>  drivers/cpuidle/cpuidle-armada-370-xp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidle/cpuidle-armada-370-xp.c
> index 28587d0f3947..a5fba0287bfb 100644
> --- a/drivers/cpuidle/cpuidle-armada-370-xp.c
> +++ b/drivers/cpuidle/cpuidle-armada-370-xp.c
> @@ -55,7 +55,7 @@ static struct cpuidle_driver armada_370_xp_idle_driver = {
>  		.power_usage		= 50,
>  		.target_residency	= 100,
>  		.flags			= CPUIDLE_FLAG_TIME_VALID,
> -		.name			= "MV CPU IDLE",
> +		.name			= "Idle",
>  		.desc			= "CPU power down",
>  	},
>  	.states[2]		= {
> @@ -65,7 +65,7 @@ static struct cpuidle_driver armada_370_xp_idle_driver = {
>  		.target_residency	= 1000,
>  		.flags			= CPUIDLE_FLAG_TIME_VALID |
>  						ARMADA_370_XP_FLAG_DEEP_IDLE,
> -		.name			= "MV CPU DEEP IDLE",
> +		.name			= "Deep idle",
>  		.desc			= "CPU and L2 Fabric power down",
>  	},
>  	.state_count = ARMADA_370_XP_MAX_STATES,
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
