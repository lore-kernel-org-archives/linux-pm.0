From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v4 2/2] thermal: rcar_gen3_thermal: disable interrupt in
 .remove
Date: Wed, 24 Apr 2019 14:31:15 +0200
Message-ID: <20190424123115.GB22366@vmlxhi-102.adit-jv.com>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
 <20190424051145.23072-3-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424051145.23072-3-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, george_davis@mentor.com, joshua_frkuska@mentor.com, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 24, 2019 at 02:11:45PM +0900, Jiada Wang wrote:
> Currently IRQ remains enabled after .remove, later if device is probed,
> IRQ is requested before .thermal_init, this may cause IRQ function be
> called before device is initialized.
> 
> this patch disables interrupt in .remove, to ensure irq function
> only be called after device is fully initialized.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Based on https://patchwork.kernel.org/cover/10914079/#22603533 :

Reviewed-and-Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Thanks!

-- 
Best regards,
Eugeniu.
