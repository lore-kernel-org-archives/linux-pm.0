Return-Path: <SRS0=TlO+=ST=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4395C10F12
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 06:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F58C20674
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 06:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDQGHq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:07:46 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:1561 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbfDQGHq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2019 02:07:46 -0400
X-IronPort-AV: E=Sophos;i="5.60,360,1549926000"; 
   d="scan'208";a="303136305"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 08:07:43 +0200
Date:   Wed, 17 Apr 2019 08:07:42 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        devel@acpica.org, linux-acpi@vger.kernel.org, kbuild-all@01.org
Subject: [pm:bleeding-edge 75/85] drivers/base/swnode.c:587:23-27: ERROR:
 swnode is NULL but dereferenced. (fwd)
Message-ID: <alpine.DEB.2.21.1904170806020.2612@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

The problem appears to be on line 551.  swnode can't be NULL after the
lock is taken.  Perhaps the test is just not needed, or perhaps something
else was intended to be checked.

julia

---------- Forwarded message ----------
Date: Wed, 17 Apr 2019 08:37:13 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [pm:bleeding-edge 75/85] drivers/base/swnode.c:587:23-27: ERROR: swnode
     is NULL but dereferenced.

CC: kbuild-all@01.org
CC: linux-acpi@vger.kernel.org
CC: devel@acpica.org
CC: linux-pm@vger.kernel.org
TO: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   98438d88cbe65037744bdc071720389797f9c575
commit: 7b68d5fe9581aed81d84280891f9a8b1508c911b [75/85] software node: Implement .get_reference_args fwnode operation
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> drivers/base/swnode.c:587:23-27: ERROR: swnode is NULL but dereferenced.

# https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=7b68d5fe9581aed81d84280891f9a8b1508c911b
git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
git remote update pm
git checkout 7b68d5fe9581aed81d84280891f9a8b1508c911b
vim +587 drivers/base/swnode.c

59abd836 Heikki Krogerus 2018-11-09  536
7b68d5fe Heikki Krogerus 2019-04-12  537  static int
7b68d5fe Heikki Krogerus 2019-04-12  538  software_node_get_reference_args(const struct fwnode_handle *fwnode,
7b68d5fe Heikki Krogerus 2019-04-12  539  				 const char *propname, const char *nargs_prop,
7b68d5fe Heikki Krogerus 2019-04-12  540  				 unsigned int nargs, unsigned int index,
7b68d5fe Heikki Krogerus 2019-04-12  541  				 struct fwnode_reference_args *args)
7b68d5fe Heikki Krogerus 2019-04-12  542  {
7b68d5fe Heikki Krogerus 2019-04-12  543  	struct software_node *swnode = to_software_node(fwnode);
7b68d5fe Heikki Krogerus 2019-04-12  544  	struct software_node_reference *ref;
7b68d5fe Heikki Krogerus 2019-04-12  545  	const struct property_entry *prop;
7b68d5fe Heikki Krogerus 2019-04-12  546  	int ret = -ENOENT;
7b68d5fe Heikki Krogerus 2019-04-12  547  	int i;
7b68d5fe Heikki Krogerus 2019-04-12  548
7b68d5fe Heikki Krogerus 2019-04-12  549  	mutex_lock(&swnode->lock);
7b68d5fe Heikki Krogerus 2019-04-12  550
7b68d5fe Heikki Krogerus 2019-04-12  551  	if (!swnode || list_empty(&swnode->references))
7b68d5fe Heikki Krogerus 2019-04-12  552  		goto err_unlock;
7b68d5fe Heikki Krogerus 2019-04-12  553
7b68d5fe Heikki Krogerus 2019-04-12  554  	if (nargs_prop) {
7b68d5fe Heikki Krogerus 2019-04-12  555  		prop = property_entry_get(swnode->properties, nargs_prop);
7b68d5fe Heikki Krogerus 2019-04-12  556  		if (!prop) {
7b68d5fe Heikki Krogerus 2019-04-12  557  			ret = -EINVAL;
7b68d5fe Heikki Krogerus 2019-04-12  558  			goto err_unlock;
7b68d5fe Heikki Krogerus 2019-04-12  559  		}
7b68d5fe Heikki Krogerus 2019-04-12  560
7b68d5fe Heikki Krogerus 2019-04-12  561  		nargs = prop->value.u32_data;
7b68d5fe Heikki Krogerus 2019-04-12  562  	}
7b68d5fe Heikki Krogerus 2019-04-12  563
7b68d5fe Heikki Krogerus 2019-04-12  564  	if (nargs > NR_FWNODE_REFERENCE_ARGS) {
7b68d5fe Heikki Krogerus 2019-04-12  565  		ret = -EINVAL;
7b68d5fe Heikki Krogerus 2019-04-12  566  		goto err_unlock;
7b68d5fe Heikki Krogerus 2019-04-12  567  	}
7b68d5fe Heikki Krogerus 2019-04-12  568
7b68d5fe Heikki Krogerus 2019-04-12  569  	list_for_each_entry(ref, &swnode->references, list) {
7b68d5fe Heikki Krogerus 2019-04-12  570  		if (strcmp(ref->name, propname))
7b68d5fe Heikki Krogerus 2019-04-12  571  			continue;
7b68d5fe Heikki Krogerus 2019-04-12  572
7b68d5fe Heikki Krogerus 2019-04-12  573  		if (index > (ref->nrefs - 1))
7b68d5fe Heikki Krogerus 2019-04-12  574  			break;
7b68d5fe Heikki Krogerus 2019-04-12  575
7b68d5fe Heikki Krogerus 2019-04-12  576  		args->nargs = nargs;
7b68d5fe Heikki Krogerus 2019-04-12  577  		args->fwnode = software_node_get(ref->args[index].fwnode);
7b68d5fe Heikki Krogerus 2019-04-12  578
7b68d5fe Heikki Krogerus 2019-04-12  579  		for (i = 0; i < nargs; i++)
7b68d5fe Heikki Krogerus 2019-04-12  580  			args->args[i] = ref->args[index].args[i];
7b68d5fe Heikki Krogerus 2019-04-12  581
7b68d5fe Heikki Krogerus 2019-04-12  582  		ret = 0;
7b68d5fe Heikki Krogerus 2019-04-12  583  		break;
7b68d5fe Heikki Krogerus 2019-04-12  584  	}
7b68d5fe Heikki Krogerus 2019-04-12  585
7b68d5fe Heikki Krogerus 2019-04-12  586  err_unlock:
7b68d5fe Heikki Krogerus 2019-04-12 @587  	mutex_unlock(&swnode->lock);
7b68d5fe Heikki Krogerus 2019-04-12  588
7b68d5fe Heikki Krogerus 2019-04-12  589  	return ret;
7b68d5fe Heikki Krogerus 2019-04-12  590  }
7b68d5fe Heikki Krogerus 2019-04-12  591

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
