From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC][PATCH 0/2] cpufreq: intel_pstate: Make it possible to
 change operation mode on the fly
Date: Thu, 05 Jan 2017 13:29:47 -0800
Message-ID: <1483651787.4497.118.camel@linux.intel.com>
References: <21825845.nN3skUNMsO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:39586 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938913AbdAEVaU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Jan 2017 16:30:20 -0500
In-Reply-To: <21825845.nN3skUNMsO@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

On Thu, 2017-01-05 at 02:50 +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> This two-patch series adds a sysfs attribute to intel_pstate to allow
> user space
> to change the way the driver works or disable it altogether.
> 
> Refer to the changelog of patch [2/2] for details.
> 
> The patches are on top of the linux-next branch of the linux-pm.git
> tree.
Tested this change and works as described in the change log.
So looks fine to me.

Thanks,
Srinivas

