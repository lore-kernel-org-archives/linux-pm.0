From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V2 1/6] PM / OPP: Free resources and properly return
 error on failure
Date: Tue, 11 Aug 2015 20:11:32 +0300
Message-ID: <20150811171132.GA25166@mwanda>
References: <cover.1439288881.git.viresh.kumar@linaro.org>
 <334a9052264630b9157fa9bfc3d4efe945054c34.1439288881.git.viresh.kumar@linaro.org>
 <20150811144345.GN5180@mwanda>
 <20150811145938.GA32049@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:49394 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965269AbbHKROQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 13:14:16 -0400
Content-Disposition: inline
In-Reply-To: <20150811145938.GA32049@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On Tue, Aug 11, 2015 at 08:29:38PM +0530, Viresh Kumar wrote:
> > This is weird to me, because we are going backwards.  What happens if
> > we goto free_table without adding anything?
> 
> It will WARN() today.

Then the current code is buggy.

> 
> > I suspect it's fine, but if
> > it's a bug then this code still has problems.
> 
> I don't think we have a bug here, we never added anything and so don't
> need to free it.
> 
> > What about if we only increment count when _opp_add_static_v2()
> > succeeds
> 
> That's not what we want.

If the first call to _opp_add_static_v2() fails we call
of_free_opp_table() and you say that triggers a WARN().

regards,
dan carpenter

