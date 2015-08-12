From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/6] PM / OPP: Free resources and properly return
 error on failure
Date: Wed, 12 Aug 2015 15:40:10 +0530
Message-ID: <20150812101010.GA32432@linux>
References: <cover.1439288881.git.viresh.kumar@linaro.org>
 <334a9052264630b9157fa9bfc3d4efe945054c34.1439288881.git.viresh.kumar@linaro.org>
 <20150811144345.GN5180@mwanda>
 <20150811145938.GA32049@linux>
 <20150811171132.GA25166@mwanda>
 <20150812064309.GL32049@linux>
 <20150812081113.GC32040@mwanda>
 <20150812082302.GD16445@linux>
 <20150812090351.GE32040@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33388 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbbHLKKQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 06:10:16 -0400
Received: by pabyb7 with SMTP id yb7so11598177pab.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2015 03:10:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150812090351.GE32040@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 12-08-15, 12:03, Dan Carpenter wrote:
> It's a lot better but it would be better yet with a return 0;.  There is
> an earlier goto put_opp_np on the success path, but that's fine.  It's
> not the normal success path so it's necessarily complicated.

I see where you are coming from and it makes lot of sense. Thanks for
the teaching part :)

> Anyway, here is what I would suggest:
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 51b220e..243317c 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -1317,19 +1317,23 @@ static int _of_init_opp_table_v2(struct device *dev,
>  
>  	/* We have opp-list node now, iterate over it and add OPPs */
>  	for_each_available_child_of_node(opp_np, np) {
> -		count++;
> -
>  		ret = _opp_add_static_v2(dev, np);
>  		if (ret) {
>  			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
>  				ret);
>  			break;
>  		}
> +		count++;
>  	}
>  
>  	/* There should be one of more OPP defined */
> -	if (WARN_ON(!count))
> +	if (WARN_ON(!count)) {

This is wrong. _opp_add_static_v2() failed and so count was 0. And we
aren't supposed to WARN() in this case. We only WARN if the user
hasn't added any available nodes in the opp table.

> +		ret = -ENOENT;
>  		goto put_opp_np;
> +	}
> +	if (ret)
> +		goto free_table;

Also the 'put_opp_np' thing is getting removed, check 2/6 patch of
this series.

What about this:

Message-Id: <e2412c33aa6923767b394adffee9d3f7be1ee27f.1439373912.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 11 Aug 2015 14:23:34 +0530
Subject: [PATCH] PM / OPP: Free resources and properly return error on failure

_of_init_opp_table_v2() isn't freeing up resources on some errors and
the error values returned are also not correct always.

This fixes following problems:
- Return -ENOENT, if no entries are found in the table.
- Use IS_ERR() to properly check return value of _find_device_opp().
- Return error value with PTR_ERR() in above case.
- Free table if _find_device_opp() fails.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 204c6c945168..4d6c4576f7ae 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1323,28 +1323,30 @@ static int _of_init_opp_table_v2(struct device *dev,
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
-			break;
+			goto free_table;
 		}
 	}
 
 	/* There should be one of more OPP defined */
-	if (WARN_ON(!count))
+	if (WARN_ON(!count)) {
+		ret = -ENOENT;
 		goto put_opp_np;
+	}
 
-	if (!ret) {
-		if (!dev_opp) {
-			dev_opp = _find_device_opp(dev);
-			if (WARN_ON(!dev_opp))
-				goto put_opp_np;
-		}
-
-		dev_opp->np = opp_np;
-		dev_opp->shared_opp = of_property_read_bool(opp_np,
-							    "opp-shared");
-	} else {
-		of_free_opp_table(dev);
+	dev_opp = _find_device_opp(dev);
+	if (WARN_ON(IS_ERR(dev_opp))) {
+		ret = PTR_ERR(dev_opp);
+		goto free_table;
 	}
 
+	dev_opp->np = opp_np;
+	dev_opp->shared_opp = of_property_read_bool(opp_np, "opp-shared");
+
+	of_node_put(opp_np);
+	return 0;
+
+free_table:
+	of_free_opp_table(dev);
 put_opp_np:
 	of_node_put(opp_np);
 
