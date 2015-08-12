From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/6] PM / OPP: Free resources and properly return
 error on failure
Date: Wed, 12 Aug 2015 12:13:09 +0530
Message-ID: <20150812064309.GL32049@linux>
References: <cover.1439288881.git.viresh.kumar@linaro.org>
 <334a9052264630b9157fa9bfc3d4efe945054c34.1439288881.git.viresh.kumar@linaro.org>
 <20150811144345.GN5180@mwanda>
 <20150811145938.GA32049@linux>
 <20150811171132.GA25166@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33828 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbbHLGns (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 02:43:48 -0400
Received: by pdbfa8 with SMTP id fa8so4032041pdb.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 23:43:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150811171132.GA25166@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 11-08-15, 20:11, Dan Carpenter wrote:
> On Tue, Aug 11, 2015 at 08:29:38PM +0530, Viresh Kumar wrote:
> > > This is weird to me, because we are going backwards.  What happens if
> > > we goto free_table without adding anything?
> > 
> > It will WARN() today.
> 
> Then the current code is buggy.

Urg, it wouldn't WARN in this case. Sorry, didn't read it correctly
earlier.

> > > I suspect it's fine, but if
> > > it's a bug then this code still has problems.
> > 
> > I don't think we have a bug here, we never added anything and so don't
> > need to free it.
> > 
> > > What about if we only increment count when _opp_add_static_v2()
> > > succeeds
> > 
> > That's not what we want.
> 
> If the first call to _opp_add_static_v2() fails we call
> of_free_opp_table() and you say that triggers a WARN().

No it doesn't.

So, coming back to the point you made about freeing table on !count,
because there were no nodes present in the DT opp table, we have never
tried to add any OPPs. And so there is no need to call
of_free_opp_table() in that case.

Do you still think the current code is wrong ?

-- 
viresh
