From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 1/5] Documentation: Add support for TI System Control
 Interface (TI-SCI) protocol
Date: Fri, 16 Sep 2016 07:13:47 -0500
Message-ID: <20160916121347.GA29618@rob-hp-laptop>
References: <20160906190127.23522-1-nm@ti.com>
 <20160906190127.23522-2-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33273 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757532AbcIPMNu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Sep 2016 08:13:50 -0400
Content-Disposition: inline
In-Reply-To: <20160906190127.23522-2-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russ Dill <Russ.Dill@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Andrew F . Davis" <afd@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Tue, Sep 06, 2016 at 02:01:23PM -0500, Nishanth Menon wrote:
> Texas Instrument's System Control Interface (TI-SCI) Message Protocol
> is used in Texas Instrument's System on Chip (SoC) such as those in
> newer SoCs in the keystone processor family starting with K2G.
> 
> This message protocol is used to communicate between various compute
> or processing entities (such as ARM, DSP etc.) with a central system
> controller entity.
> 
> TI-SCI message protocol provides support for management of various
> hardware entities within the SoC.
> 
> The message protocol can be found here:
> http://processors.wiki.ti.com/index.php/TISCI
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in V3:
> 	- All dependent nodes like PD/Clk are children of TISCI node
> 	- minor formatting updates
> 
> V2: https://patchwork.kernel.org/patch/9305413/
> V1: https://patchwork.kernel.org/patch/9291343/
> 
>  .../devicetree/bindings/arm/keystone/ti,sci.txt    | 81 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt

Acked-by: Rob Herring <robh@kernel.org>
