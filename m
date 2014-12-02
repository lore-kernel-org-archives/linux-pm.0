From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH 16/26] cpu_cooling: Drop useless locking around
 idr_alloc/idr_remove
Date: Tue, 2 Dec 2014 15:53:43 +0000
Message-ID: <20141202155343.GD2834@e104805>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <a71abc2219d80e9b8e77599d2e60612a96bb36a9.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:56498 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbaLBPxr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 10:53:47 -0500
In-Reply-To: <a71abc2219d80e9b8e77599d2e60612a96bb36a9.1417167599.git.viresh.kumar@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>

Hi Viresh,

On Fri, Nov 28, 2014 at 09:44:10AM +0000, Viresh Kumar wrote:
> Locking around idr_alloc/idr_remove looks rather pointless as there is no race
> it is trying to fix. Remove it.

You are assuming that all cpufreq cooling devices are registered
sequentially, one after the other.  That doesn't need be the case.  I
don't think the performance that you get from this patch justifies the
possible races that could be introduced by not having the locking.
Why should we remove this?

> get_idr() and release_idr() aren't much useful now, so get rid of them as well.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> @Eduardo: Same is true for thermal-core as well ?

I think that my previous concern applies to thermal_core as well,
thermal zones may not be initialised sequentially.

Cheers,
Javi

