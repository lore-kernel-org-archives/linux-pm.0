From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 8/8] platform: x86: intel_bxtwc_tmu: remove first
 level irq unmask
Date: Mon, 24 Apr 2017 10:26:35 +0100
Message-ID: <20170424092635.oznzvugqxdisw7k7@dell>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <93377b77b9493d79de48741b030fa1b03f80094f.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170421220025.GC31650@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170421220025.GC31650@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, rui.zhang@intel.com, andy@infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Apr 2017, Darren Hart wrote:

> On Fri, Apr 14, 2017 at 04:26:00PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > Currently in WCOVE PMIC mfd driver, all second level irq chips
> 
> By currently I believe you mean after the earlier patch in this series is
> applied, correct? This one is dependent on the previous one?
> 
> > are chained to the respective first level irqs. So there is no
> > need for explicitly unmasking the first level irq in this
> > driver. This patches removes this level 1 irq unmask support.
> > 
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> For platform drivers x86:
> 
> Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>
> 
> Are you working with a specific maintainers to pull this in as a series? With so
> many subsystems, we need to coordinate to make sure we don't make a mess for
> Linus. Given the interdependencies, I'd recommend someone pull the series in as
> a whole - maybe into MFD? Lee, do you have a preference?

I am happy to take the set, however I think v4.12 is an unlikely
candidate, since there still have quite a few patches which are yet to
receive review and the merge-window opens in 6 days.

Once we have all the required Acks, I'll push the set into -next where
it can sit for a good soak test until v4.13.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
