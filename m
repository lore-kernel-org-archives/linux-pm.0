Return-Path: <SRS0=lDgx=WE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B5AC0650F
	for <linux-pm@archiver.kernel.org>; Thu,  8 Aug 2019 20:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBE721743
	for <linux-pm@archiver.kernel.org>; Thu,  8 Aug 2019 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294636;
	bh=XKTewYNW5u4u5EpWVDYYrn/auYfBYt+Fs75L4VKojK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CAzRj8mvYfQsM0+Kltynwdg+7Xo0pOE0VSibV84FYvwASTtQ6bCAju++pWijiSTii
	 OFKhKKvo3mYWBnE5RUAsN/hyb/Kl6fJRnpLUYgAD/IVfxRNtfmRBMf6VBA3iFvbw/y
	 X5x/mWyxH8rIyRSQ/7u6O2bs41mke5V4HjnY8qYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404125AbfHHUDz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:03:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:35369 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389883AbfHHUDz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 16:03:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 13:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="165801725"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 08 Aug 2019 13:03:53 -0700
Date:   Thu, 8 Aug 2019 14:01:28 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] nvme-pci: Allow PCI bus-level PM to be used if
 ASPM is disabled
Message-ID: <20190808200128.GC27077@localhost.localdomain>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain>
 <1921165.pTveHRX1Co@kreacher>
 <1870928.r7tBYyfqdz@kreacher>
 <20190808134356.GF151852@google.com>
 <CAJZ5v0h=nz8yXwOOGBUB9m1GtJPOqBwtNK7zXPNMJjzPhMWd9w@mail.gmail.com>
 <20190808183954.GG151852@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808183954.GG151852@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 01:39:54PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 08, 2019 at 04:47:45PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Aug 8, 2019 at 3:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > IIUC the NVMe device will go to the desired package idle state if
> > > the link is in L0s or L1, but not if the link is in L0.  I don't
> > > understand that connection; AFAIK that would be something outside
> > > the scope of the PCIe spec.
> > 
> > Yes, it is outside of the PCIe spec.
> > 
> > No, this is not about the NVMe device, it is about the Intel SoC
> > (System-on-a-Chip) the platform is based on.
> 
> Ah.  So this problem could occur with any device, not just NVMe?  If
> so, how do you address that?  Obviously you don't want to patch all
> drivers this way.

We discovered this when using an NVMe protocol specific power setting, so
that part is driver specific. We just have to ensure device generic
dependencies are met in order to achieve the our power target. So in
that sense, I think you would need to patch all drivers if they're also
using protocol specific settings incorrectly.

Granted, the NVMe specification doesn't detail what PCIe settings may
prevent NVMe power management from hitting the objective, but I think
ASPM enabled makes sense.
