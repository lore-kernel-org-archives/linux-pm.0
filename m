From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3_thermal: fix interrupt type
Date: Tue, 23 Apr 2019 15:07:24 +0200
Message-ID: <20190423130724.GA10913@vmlxhi-102.adit-jv.com>
References: <20190423061218.29705-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423061218.29705-2-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, joshua_frkuska@mentor.com, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <rosca.eugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Jiada,

On Tue, Apr 23, 2019 at 03:12:17PM +0900, Jiada Wang wrote:
> Currently IRQF_SHARED type interrupt line is allocated, but it
> is not appropriate, as the interrupt line isn't shared between
> different devices, instead IRQF_ONESHOT is the proper type.
> 
> By changing interrupt type to IRQF_ONESHOT, now irq handler is
> no longer needed, as clear of interrupt status can be done in
> threaded interrupt context.
> 
> Because IRQF_ONESHOT type interrupt line is kept disabled until
> the threaded handler has been run, so there is no need to protect
> read/write of REG_GEN3_IRQSTR with lock.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  drivers/thermal/rcar_gen3_thermal.c | 40 ++++++++---------------------
>  1 file changed, 10 insertions(+), 30 deletions(-)
>

[..]

I might be doing something wrong, but I couldn't apply this patch on top
of v5.1-rc6-4-g7142eaa58b49. All below commands failed (git v2.21.0):
 - git am this.patch
 - git apply this.patch
 - patch -p1 < this.patch

-- 
Best regards,
Eugeniu.
