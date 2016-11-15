From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2] thermal: intel_pch_thermal: Support skylake PCH 100
 series thermal
Date: Tue, 15 Nov 2016 20:20:10 +0800
Message-ID: <1479212410.2224.11.camel@intel.com>
References: <87pomyd515.fsf@mail.parknet.co.jp>
         <1476813814.132953.50.camel@intel.com> <87eg3dctaj.fsf@mail.parknet.co.jp>
         <1476821756.132953.56.camel@intel.com> <8760opcr4y.fsf@mail.parknet.co.jp>
         <871szdcr0u.fsf_-_@mail.parknet.co.jp>
         <1476824673.132953.57.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:47071 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932786AbcKOMUn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Nov 2016 07:20:43 -0500
In-Reply-To: <1476824673.132953.57.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "hirofumi@mail.parknet.co.jp" <hirofumi@mail.parknet.co.jp>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, 2016-10-18 at 15:04 -0600, Pandruvada, Srinivas wrote:
> On Wed, 2016-10-19 at 05:59 +0900, OGAWA Hirofumi wrote:
> > 
> > This patch uses .driver_data and board_info[] to make per pci device
> > behavior table (name and ops), instead of adding the code for each
> > pci
> > device in switch-case. This will make easier to add new pci device
> > ids.
> > 
> > Then this adds new device id actually for skylake PCH 100 series
> > (using registers are compatible with currently driver, so no need to
> > change except adding device id to table).
> > 
> > Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
hmmm, this patch is queued in my tree for some time.
However, it conflicts with
commit 33086a9a3071812a829d4b63bed826736a5d8b17
Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Mon Oct 3 12:36:02 2016 -0700

    thermal: intel_pch_thermal: Enable Haswell PCH
    
    Added missing support for Haswell PCH thermal sensor.
which has been shipped in v4.9-rc3.

Rebased patch sent, please double check.

thanks,
rui



