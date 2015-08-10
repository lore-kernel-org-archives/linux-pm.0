From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: PM / OPP: Add OPP sharing information to OPP library
Date: Mon, 10 Aug 2015 19:40:09 +0300
Message-ID: <20150810164009.GB10496@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:16386 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbbHJQkb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 12:40:31 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org

Hello Viresh Kumar,

The patch 064416586190: "PM / OPP: Add OPP sharing information to OPP
library" from Jul 29, 2015, leads to the following static checker
warning:

	drivers/base/power/opp.c:1341 _of_init_opp_table_v2()
	error: 'dev_opp' dereferencing possible ERR_PTR()

drivers/base/power/opp.c
  1328          }
  1329  
  1330          /* There should be one of more OPP defined */
  1331          if (WARN_ON(!count))
  1332                  goto put_opp_np;

Should we set "ret" here?

  1333  
  1334          if (!ret) {
  1335                  if (!dev_opp) {
                             ^^^^^^^
No need to test this, we tested at the start of the function.

  1336                          dev_opp = _find_device_opp(dev);
  1337                          if (WARN_ON(!dev_opp))

This should be checking for IS_ERR().  We probably want to set "ret =
PTR_ERR(dev_opp) as well.

  1338                                  goto put_opp_np;
  1339                  }
  1340  
  1341                  dev_opp->np = opp_np;
  1342                  dev_opp->shared_opp = of_property_read_bool(opp_np,
  1343                                                              "opp-shared");
  1344          } else {
  1345                  of_free_opp_table(dev);
  1346          }
  1347  
  1348  put_opp_np:
  1349          of_node_put(opp_np);
  1350  
  1351          return ret;
  1352  }

Checking for "!ret" on line 1334 is "success handling" style code.
Success handling leads to multiple indent levels and is more twisted and
confusing.  I generally prefer to keep my error handling paths separate
from the success path although in this case we call of_node_put() on
both paths, so maybe a shared exit path makes sense.

To me boils down to a question of, "How much is shared and how much is
different.  Also should we call of_free_opp_table() if _find_device_opp()
fails?"  If not then I would use a common exit path, otherwise I would
split them apart.

Shared:

	if (ret) {
		of_free_opp_table(dev);
		goto put_opp_npl;
	}

	dev_opp = _find_device_opp(dev);
	if (WARN_ON(IS_ERR(dev_opp))) {
		ret = PTR_ERR(dev_opp);
		goto put_opp_np;
	}

	dev_opp->np = opp_np;
	dev_opp->shared_opp = of_property_read_bool(opp_np, "opp-shared");

put_opp_np:
	of_node_put(opp_np);
	return ret;

Split apart:

	if (ret)
		goto free_opp_table;

	dev_opp = _find_device_opp(dev);
	if (WARN_ON(IS_ERR(dev_opp))) {
		ret = PTR_ERR(dev_opp);
		goto free_opp_table;
	}

	dev_opp->np = opp_np;
	dev_opp->shared_opp = of_property_read_bool(opp_np, "opp-shared");

	of_node_put(opp_np);
	return 0;

free_opp_table:
	of_free_opp_table(dev);
put_opp_np:
	of_node_put(opp_np);
	return ret;

regards,
dan carpenter
