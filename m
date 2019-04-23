From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v1 1/1] thermal: rcar_gen3_thermal: request IRQ after
 device initialization
Date: Tue, 23 Apr 2019 12:01:07 +0200
Message-ID: <20190423100107.p3p3jmvv6dph6uy6@verge.net.au>
References: <20190411100352.15977-1-jiada_wang@mentor.com>
 <20190416174741.GA26470@vmlxhi-102.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190416174741.GA26470@vmlxhi-102.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Jiada Wang <jiada_wang@mentor.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Geert Uytterhoeven <geert+renesas@glider.be>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Hien Dang <hien.dang.eb@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Dien Pham <dien.pham.ry@renesas.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Biju Das <biju.das@bp.renesas.com>, "George G. Davis" <george_davis@mentor.com>, Joshua Frkuska <joshua_frkuska@mentor.com>, Eugeniu Rosca <roscaeugeniu@gmail>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 16, 2019 at 07:48:30PM +0200, Eugeniu Rosca wrote:
> Hi Jiada,
> 
> Adding below people, since they've made recent contributions to the
> driver and might be interested in your patch:
> 
> git log master --since="1 year" -- drivers/thermal/rcar_gen3_thermal.c \
>     | grep -o "\-by:.*" | sed 's/\-by: //' | sort | uniq -c | sort -rn
>       7 Eduardo Valentin <edubezval@gmail.com>
>       6 Simon Horman <horms+renesas@verge.net.au>
>       5 Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>       2 Geert Uytterhoeven <geert+renesas@glider.be>
>       1 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>       1 Marek Vasut <marek.vasut+renesas@gmail.com>
>       1 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>       1 Hien Dang <hien.dang.eb@renesas.com>
>       1 Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>       1 Dien Pham <dien.pham.ry@renesas.com>
>       1 Daniel Lezcano <daniel.lezcano@linaro.org>
>       1 Biju Das <biju.das@bp.renesas.com>
> 
> I confirm that loading and unloading the rcar3 thermal driver in a
> loop produces soft lockup using v5.1-rc5-10-g618d919cae2f on
> H3-ES2.0-Salvator-X. 
> 
> Full log and .config can be found here:
> https://gist.github.com/erosca/1f76b6dd897cdc39581fca475155e363
> 
> I post an excerpt from the above [1] (why not including it in the
> description?). Also, why not rephrasing the commit summary line in such
> a way that everybody understands this patch fixes a severe issue, e.g.
> "thermal: rcar_gen3_thermal: Fix soft lockup on probe" ?
> 
> BTW, with this patch applied I left the thermal driver being
> loaded/unloaded on the target for over one hour w/o seeing the issue
> reproduced. So, while there might be slight variations in how the final
> solution looks like, I think the patch already deserves a:
> 
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> 
> [1] Soft lockup reproduced with v5.1-rc5-10-g618d919cae2f

Thanks,

Unfortunately I do not see the patch in my inbox.
Would you care to repost it including the following recipients.

linux-pm@vger.kernel.org
Zhang Rui <rui.zhang@intel.com>
Eduardo Valentin <edubezval@gmail.com>
linux-renesas-soc@vger.kernel.org
Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Feel free to include the suggestions made by Eugeniu above and post a v2.
