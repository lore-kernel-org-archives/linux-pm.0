From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] devfreq_cooling: return on allocation failure
Date: Wed, 4 Nov 2015 16:36:20 +0300
Message-ID: <20151104133620.GF20966@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, =?iso-8859-1?Q?=D8rjan?= Eide <orjan.eide@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If the allocation fails then we can't continue.

Fixes: a76caf55e5b3 ('thermal: Add devfreq cooling')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index a272068..d741f09 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -397,7 +397,7 @@ static int devfreq_cooling_gen_tables(struct devfreq_cooling_device *dfc)
 		power_table = kcalloc(num_opps, sizeof(*power_table),
 				      GFP_KERNEL);
 		if (!power_table)
-			ret = -ENOMEM;
+			return -ENOMEM;
 	}
 
 	freq_table = kcalloc(num_opps, sizeof(*freq_table),
