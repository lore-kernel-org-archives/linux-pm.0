From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 2/2] ARM: dts: r8a7743: Add thermal device to DT
Date: Wed, 20 Dec 2017 12:48:44 +0100
Message-ID: <20171220114844.w35ain6w6tvecfgo@verge.net.au>
References: <1513689449-2700-1-git-send-email-biju.das@bp.renesas.com>
 <1513689449-2700-3-git-send-email-biju.das@bp.renesas.com>
 <20171220085036.gdcnbhonyqlewyi4@verge.net.au>
 <KL1PR06MB17029FA8C7AD57F067777E11B80C0@KL1PR06MB1702.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <KL1PR06MB17029FA8C7AD57F067777E11B80C0@KL1PR06MB1702.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 20, 2017 at 11:36:51AM +0000, Biju Das wrote:
> Hi Simon,
> 
> Just noticed that
> 
> # make dtbs W=1 is giving below warning message.
> 
> arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> 
> Do you prefer a fix patch or a v2 ?

I believe I have fixed that by applying
"ARM: dts: r8a7743: move timer and thermal-zones nodes out of bus"

Could you check the devel branch when I push it a little later today?
