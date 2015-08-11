From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: PM / OPP: Add OPP sharing information to OPP library
Date: Tue, 11 Aug 2015 13:52:09 +0530
Message-ID: <20150811082209.GD5509@linux>
References: <20150810164009.GB10496@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35858 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933623AbbHKIWO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 04:22:14 -0400
Received: by pacrr5 with SMTP id rr5so122750152pac.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 01:22:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150810164009.GB10496@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-pm@vger.kernel.org

Hi Dan,

Are the static checker scripts available (and easy to use) for others
as well? Maybe I can use them on code, before sending patches.

On 10-08-15, 19:40, Dan Carpenter wrote:
> Hello Viresh Kumar,
> 
> The patch 064416586190: "PM / OPP: Add OPP sharing information to OPP
> library" from Jul 29, 2015, leads to the following static checker
> warning:
> 
> 	drivers/base/power/opp.c:1341 _of_init_opp_table_v2()
> 	error: 'dev_opp' dereferencing possible ERR_PTR()
> 
> drivers/base/power/opp.c
>   1328          }
>   1329  
>   1330          /* There should be one of more OPP defined */
>   1331          if (WARN_ON(!count))
>   1332                  goto put_opp_np;
> 
> Should we set "ret" here?

Yes, one of my new patches is doing this.

>   1333  
>   1334          if (!ret) {
>   1335                  if (!dev_opp) {
>                              ^^^^^^^
> No need to test this, we tested at the start of the function.

Yes, I have killed this extra indentation level as well.

>   1336                          dev_opp = _find_device_opp(dev);
>   1337                          if (WARN_ON(!dev_opp))
> 
> This should be checking for IS_ERR().  We probably want to set "ret =
> PTR_ERR(dev_opp) as well.

Okay, that's new. Will fix.

>   1338                                  goto put_opp_np;
>   1339                  }
>   1340  
>   1341                  dev_opp->np = opp_np;
>   1342                  dev_opp->shared_opp = of_property_read_bool(opp_np,
>   1343                                                              "opp-shared");
>   1344          } else {
>   1345                  of_free_opp_table(dev);
>   1346          }
>   1347  
>   1348  put_opp_np:
>   1349          of_node_put(opp_np);
>   1350  
>   1351          return ret;
>   1352  }
> 
> Checking for "!ret" on line 1334 is "success handling" style code.
> Success handling leads to multiple indent levels and is more twisted and
> confusing.  I generally prefer to keep my error handling paths separate
> from the success path although in this case we call of_node_put() on
> both paths, so maybe a shared exit path makes sense.
> 
> To me boils down to a question of, "How much is shared and how much is
> different.  Also should we call of_free_opp_table() if _find_device_opp()
> fails?"  If not then I would use a common exit path, otherwise I would
> split them apart.
> 
> Shared:
> 
> 	if (ret) {
> 		of_free_opp_table(dev);
> 		goto put_opp_npl;
> 	}
> 
> 	dev_opp = _find_device_opp(dev);
> 	if (WARN_ON(IS_ERR(dev_opp))) {
> 		ret = PTR_ERR(dev_opp);
> 		goto put_opp_np;
> 	}
> 
> 	dev_opp->np = opp_np;
> 	dev_opp->shared_opp = of_property_read_bool(opp_np, "opp-shared");
> 
> put_opp_np:
> 	of_node_put(opp_np);
> 	return ret;
> 
> Split apart:
> 
> 	if (ret)
> 		goto free_opp_table;
> 
> 	dev_opp = _find_device_opp(dev);
> 	if (WARN_ON(IS_ERR(dev_opp))) {
> 		ret = PTR_ERR(dev_opp);
> 		goto free_opp_table;
> 	}
> 
> 	dev_opp->np = opp_np;
> 	dev_opp->shared_opp = of_property_read_bool(opp_np, "opp-shared");
> 
> 	of_node_put(opp_np);
> 	return 0;
> 
> free_opp_table:
> 	of_free_opp_table(dev);
> put_opp_np:
> 	of_node_put(opp_np);
> 	return ret;

Will check that as well.

-- 
viresh
