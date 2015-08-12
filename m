From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/6] PM / OPP: Free resources and properly return
 error on failure
Date: Wed, 12 Aug 2015 13:53:02 +0530
Message-ID: <20150812082302.GD16445@linux>
References: <cover.1439288881.git.viresh.kumar@linaro.org>
 <334a9052264630b9157fa9bfc3d4efe945054c34.1439288881.git.viresh.kumar@linaro.org>
 <20150811144345.GN5180@mwanda>
 <20150811145938.GA32049@linux>
 <20150811171132.GA25166@mwanda>
 <20150812064309.GL32049@linux>
 <20150812081113.GC32040@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150812081113.GC32040@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 12-08-15, 11:11, Dan Carpenter wrote:
> If it doesn't WARN() then it's not buggy, but it's still ugly.  We
> should not call of_free_opp_table() because we *tried* to add an OPP, we
> should only call it if we *succeeded*.

This is done in order to write lesser code. Otherwise we need
something like this:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index bcbd92c3b717..650e92e2f2f0 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1317,14 +1317,15 @@ static int _of_init_opp_table_v2(struct device *dev,
 
 	/* We have opp-list node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
-		count++;
-
 		ret = _opp_add_static_v2(dev, np);
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
+			if (!count)
+				goto put_opp_np;
 			goto free_table;
 		}
+		count++;
 	}
 
 	/* There should be one of more OPP defined */


To some people, this will look even more *ugly*. And so I just called
free_table() on error.

> The way the code is written and from your emails I was afraid that if
> you tried to call _opp_add_static_v2() and it fails then it leaves
> artifacts lying around that need to be cleaned up by the caller.

No. The problem is that we are trying to add OPPs in a while loop and
on failure we need to free all we added earlier.

-- 
viresh
