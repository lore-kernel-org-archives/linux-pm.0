From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 2/2] thermal: rcar_gen3_thermal: disable interrupt in
 .remove
Date: Tue, 23 Apr 2019 17:44:15 +0300
Message-ID: <2d810fcf-8d31-f07e-d94a-a127127e97cd@cogentembedded.com>
References: <20190423141414.24264-1-jiada_wang@mentor.com>
 <20190423141414.24264-3-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423141414.24264-3-jiada_wang@mentor.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, erosca@de.adit-jv.com, george_davis@mentor.com, joshua_frkuska@mentor.com
List-Id: linux-pm@vger.kernel.org

On 04/23/2019 05:14 PM, Jiada Wang wrote:

> Currently IRQ is remain enabled after .remove, later if device is probed,

   IRQ remains enabled.

> IRQ is requested before .thermal_init, this may cause IRQ function be
> called before device is initialized.
> 
> this patch by disable interrupt in .remove, to ensure irq function

   s/by disable/disables/.

> only be called after device is fully initialized.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
[...]

MBR, Sergei
