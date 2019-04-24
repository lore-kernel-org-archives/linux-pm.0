From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 1/2] thermal: rcar_gen3_thermal: fix interrupt type
Date: Wed, 24 Apr 2019 11:23:30 +0200
Message-ID: <20190424092329.bfohle5relhof4v7@verge.net.au>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
 <20190424051145.23072-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424051145.23072-2-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, erosca@de.adit-jv.com, george_davis@mentor.com, joshua_frkuska@mentor.com
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 24, 2019 at 02:11:44PM +0900, Jiada Wang wrote:
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
> Fixes: 7d4b269776ec6 ("enable hardware interrupts for trip points")
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>


Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
