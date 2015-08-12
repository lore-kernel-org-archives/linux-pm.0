From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V2 1/6] PM / OPP: Free resources and properly return
 error on failure
Date: Wed, 12 Aug 2015 12:03:51 +0300
Message-ID: <20150812090351.GE32040@mwanda>
References: <cover.1439288881.git.viresh.kumar@linaro.org>
 <334a9052264630b9157fa9bfc3d4efe945054c34.1439288881.git.viresh.kumar@linaro.org>
 <20150811144345.GN5180@mwanda>
 <20150811145938.GA32049@linux>
 <20150811171132.GA25166@mwanda>
 <20150812064309.GL32049@linux>
 <20150812081113.GC32040@mwanda>
 <20150812082302.GD16445@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150812082302.GD16445@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 12, 2015 at 01:53:02PM +0530, Viresh Kumar wrote:
> On 12-08-15, 11:11, Dan Carpenter wrote:
> > If it doesn't WARN() then it's not buggy, but it's still ugly.  We
> > should not call of_free_opp_table() because we *tried* to add an OPP, we
> > should only call it if we *succeeded*.
> 
> This is done in order to write lesser code.

I have been trying to discourage you from focusing so much on the
writing fewer lines.  That little bunny hop "goto put_opp_np;" at the
end of the success path should be replaced with:

	of_node_put(opp_np);
	return 0;

It's one extra line of code, but "return 0;" is so much more clear.  A
lot of my focus for the past few years has been on error handling so I
am perhaps more sensitive than many devs.  But here is what I like:

	success_path();
	if (fail)
		fail_path();
	success_path();
	success_path();
	success_path();
	if (fail)
		fail_path();
	success_path();

	return 0;

more_fail:
	fail_path();
fail:
	fail_path();
	return ret;

The success path is a list of commands indented one tab.  The fail path
is intended two tabs or in reverse order at the bottom of the function
indented one tab.  This uses the minimum amount of if statements and
indenting.

In the original code, we had:

	success_path();
	if (fail)
		fail_path();
	success_path();
	success_path();
	success_path();
	if (success) {
		success_path();
		if (fail)
			fail_path();
	} else {
		fail_path();
	}
free:
	success_and_fail_path();
	return ret;

The original code was confusing and, as a direct result, buggy.  Now we
have improved the code so it looks something like this:

	success_path();
	if (fail)
		fail_path();
	success_path();
	success_path();
	success_path();
	if (fail)
		fail_path();

	goto free;

more_fail:
	fail_path();
free:
	success_and_fail_path();
	return ret;

It's a lot better but it would be better yet with a return 0;.  There is
an earlier goto put_opp_np on the success path, but that's fine.  It's
not the normal success path so it's necessarily complicated.

Anyway, here is what I would suggest:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 51b220e..243317c 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1317,19 +1317,23 @@ static int _of_init_opp_table_v2(struct device *dev,
 
 	/* We have opp-list node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
-		count++;
-
 		ret = _opp_add_static_v2(dev, np);
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
 			break;
 		}
+		count++;
 	}
 
 	/* There should be one of more OPP defined */
-	if (WARN_ON(!count))
+	if (WARN_ON(!count)) {
+		ret = -ENOENT;
 		goto put_opp_np;
+	}
+	if (ret)
+		goto free_table;
 

regards,
dan carpenter
