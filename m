From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/6] PM / OPP: Free resources and properly return
 error on failure
Date: Tue, 11 Aug 2015 20:29:38 +0530
Message-ID: <20150811145938.GA32049@linux>
References: <cover.1439288881.git.viresh.kumar@linaro.org>
 <334a9052264630b9157fa9bfc3d4efe945054c34.1439288881.git.viresh.kumar@linaro.org>
 <20150811144345.GN5180@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36208 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965098AbbHKO7n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 10:59:43 -0400
Received: by pacrr5 with SMTP id rr5so129465410pac.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 07:59:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150811144345.GN5180@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 11-08-15, 17:43, Dan Carpenter wrote:
> > @@ -1323,28 +1323,29 @@ static int _of_init_opp_table_v2(struct device *dev,
> >  		if (ret) {
> >  			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
> >  				ret);
> > -			break;
> > +			goto free_table;
> >  		}
> >  	}
> >  
> >  	/* There should be one of more OPP defined */
> > -	if (WARN_ON(!count))
> > +	if (WARN_ON(!count)) {
> > +		ret = -ENOENT;
> >  		goto put_opp_np;
> > +	}

The purpose of 'count' here is to see if the dtb contained any OPP
nodes or not. i.e. if we ever entered the body of
for_each_available_child_of_node() or not..

Its different than, "if we were able to add any OPPs";

> This is weird to me, because we are going backwards.  What happens if
> we goto free_table without adding anything?

It will WARN() today.

> I suspect it's fine, but if
> it's a bug then this code still has problems.

I don't think we have a bug here, we never added anything and so don't
need to free it.

> What about if we only increment count when _opp_add_static_v2()
> succeeds

That's not what we want.

-- 
viresh
