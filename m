From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 8/8] platform: x86: intel_bxtwc_tmu: remove first
 level irq unmask
Date: Fri, 21 Apr 2017 15:00:25 -0700
Message-ID: <20170421220025.GC31650@fury>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <93377b77b9493d79de48741b030fa1b03f80094f.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49819 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1042430AbdDUWAn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2017 18:00:43 -0400
Content-Disposition: inline
In-Reply-To: <93377b77b9493d79de48741b030fa1b03f80094f.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com

On Fri, Apr 14, 2017 at 04:26:00PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently in WCOVE PMIC mfd driver, all second level irq chips

By currently I believe you mean after the earlier patch in this series is
applied, correct? This one is dependent on the previous one?

> are chained to the respective first level irqs. So there is no
> need for explicitly unmasking the first level irq in this
> driver. This patches removes this level 1 irq unmask support.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

For platform drivers x86:

Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>

Are you working with a specific maintainers to pull this in as a series? With so
many subsystems, we need to coordinate to make sure we don't make a mess for
Linus. Given the interdependencies, I'd recommend someone pull the series in as
a whole - maybe into MFD? Lee, do you have a preference?

-- 
Darren Hart
VMware Open Source Technology Center
