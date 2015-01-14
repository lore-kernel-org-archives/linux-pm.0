From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/4] ARM: shmobile: Add DT support for memory controllers
Date: Thu, 15 Jan 2015 08:55:10 +0900
Message-ID: <20150114235509.GD10479@verge.net.au>
References: <1421233982-15883-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:46496 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbbANXzN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jan 2015 18:55:13 -0500
Content-Disposition: inline
In-Reply-To: <1421233982-15883-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Wed, Jan 14, 2015 at 12:12:58PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds DT binding documentation and devices nodes to
> describe memory-controllers in R-Mobile and SH-Mobile SoCs.
> 
> Currently memory controller device nodes are used only to reference PM
> domains, and prevent these PM domains from being powered down, which
> would crash the system.
> 
> As such this series is a prerequisite for adding DT PM domain support to
> sh73a0 (SH-Mobile AG5) and r7a73a4 (R-Mobile APE6).
> For r8a7740 (R-Mobile A1), this wasn't a hard prerequisite for PM
> domain support, as the A4S PM domain is never turned off anyway
> because its child PM domain A3SM contains the CPU core.
> 
> The patches for sh73a0 and r8a7740 have been sent before as part of
> (patches in) the series "[PATCH RFC 0/7] ARM: shmobile: sh73a0: DT PM
> domain support" (https://lkml.org/lkml/2014/11/19/404).
> 
> "ARM: shmobile: r8a7740 dtsi: Add memory-controller node" depends on
> the DT R-Mobile PM Domain support for r8a7740 that's queued up in
> Simon's tree under tag renesas-dt-pm-for-v3.20, as the
> memory-controller node already contains a power-domains property.
> 
> The two other dtsi patches do not add power-domains properties yet.
> These will be added when adding PM domain support for sh73a0 resp.
> r8a73a4.
> 
> Thanks!

Thanks Geert, I have queued these up.
