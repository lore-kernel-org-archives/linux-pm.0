From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 04/10] Documentation: dt: device tree bindings for
 LPDDR3 memories
Date: Thu, 25 Apr 2019 14:53:38 -0500
Message-ID: <20190425195338.GB31128@bogus>
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87@eucas1p1.samsung.com>
 <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 19, 2019 at 04:19:22PM +0200, Lukasz Luba wrote:
> The device tree bindings for LPDDR3 SDRAM memories.

Also, 'dt-bindings: ddr: ' for the subject. You've got a mixture of 
subjects with no consistency.

> 
> For specifying the AC timing parameters of the memory device
> the 'lpddr3' binding uses binding 'lpddr2-timings'.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
