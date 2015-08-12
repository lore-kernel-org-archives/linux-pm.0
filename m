From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V2 1/6] PM / OPP: Free resources and properly return
 error on failure
Date: Wed, 12 Aug 2015 11:11:39 +0300
Message-ID: <20150812081113.GC32040@mwanda>
References: <cover.1439288881.git.viresh.kumar@linaro.org>
 <334a9052264630b9157fa9bfc3d4efe945054c34.1439288881.git.viresh.kumar@linaro.org>
 <20150811144345.GN5180@mwanda>
 <20150811145938.GA32049@linux>
 <20150811171132.GA25166@mwanda>
 <20150812064309.GL32049@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:30407 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbbHLIMM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 04:12:12 -0400
Content-Disposition: inline
In-Reply-To: <20150812064309.GL32049@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On Wed, Aug 12, 2015 at 12:13:09PM +0530, Viresh Kumar wrote:
> > If the first call to _opp_add_static_v2() fails we call
> > of_free_opp_table() and you say that triggers a WARN().
> 
> No it doesn't.
> 
> So, coming back to the point you made about freeing table on !count,
> because there were no nodes present in the DT opp table, we have never
> tried to add any OPPs. And so there is no need to call
> of_free_opp_table() in that case.
> 
> Do you still think the current code is wrong ?

If it doesn't WARN() then it's not buggy, but it's still ugly.  We
should not call of_free_opp_table() because we *tried* to add an OPP, we
should only call it if we *succeeded*.

The way the code is written and from your emails I was afraid that if
you tried to call _opp_add_static_v2() and it fails then it leaves
artifacts lying around that need to be cleaned up by the caller.  This
would be the ugliest scenario.  But I looked at _opp_add_static_v2()
and looks fine.  It cleans up properly on failure.  We only need to
clean up if it succeeds.

regards,
dan carpenter
