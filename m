From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 4/4] PM / OPP: Don't create debugfs "supply-0" directory
 unnecessarily
Date: Mon, 22 May 2017 18:28:29 -0700
Message-ID: <20170523012829.GL20170@codeaurora.org>
References: <cover.1494995911.git.viresh.kumar@linaro.org>
 <4365d55b97974c12a51e32b35c2832d664b928b6.1494995911.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4365d55b97974c12a51e32b35c2832d664b928b6.1494995911.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 05/17, Viresh Kumar wrote:
> We create "supply-0" debugfs directory even if the device doesn't do
> voltage scaling. That looks confusing, as if the regulator is found but
> we never managed to get voltage levels for it.
> 
> Avoid creating such a directory unnecessarily.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp/debugfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
> index 95f433db4ac7..ce6f4832946b 100644
> --- a/drivers/base/power/opp/debugfs.c
> +++ b/drivers/base/power/opp/debugfs.c
> @@ -40,11 +40,11 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
>  				      struct dentry *pdentry)
>  {
>  	struct dentry *d;
> -	int i = 0;
> +	int i = -1;
>  	char *name;
>  
>  	/* Always create at least supply-0 directory */

Bad comment.

> -	do {
> +	while (++i < opp_table->regulator_count) {

This is a brain-melting while loop for what should be a for loop.
Please just use a for loop instead of pre-incrementing -1 and
comparing that to the unsigned type of regulator_count. i should
probably be unsigned as well.

I can only assume it was written as a do-while before because we
assumed there was always some voltage to control.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
