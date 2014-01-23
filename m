From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Thu, 23 Jan 2014 07:59:16 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C948452C575B@FMSMSX106.amr.corp.intel.com>
References: <ce1b9fc9cdcfd1fe8f9f3b8570421271dc15ae75.1390460951.git.len.brown@intel.com>
 <52E0C6F8.5050004@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24497 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbaAWH7S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2014 02:59:18 -0500
In-Reply-To: <52E0C6F8.5050004@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Len Brown <lenb@kernel.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zhang, Rui" <rui.zhang@intel.com>

> How about naming it as PM_SLEEP_FS_SYNC (and similarly in the sysfs
> files
> and variable names as well). Just to avoid confusion with
> "synchronous/async".


good point -- thanks!


