From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/7] PM / Domains: Add DT bindings for the R-Car
 System Controller
Date: Thu, 17 Mar 2016 14:17:07 -0500
Message-ID: <20160317191707.GA2713@rob-hp-laptop>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be>
 <1457551122-21838-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48235 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935583AbcCQTRN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Mar 2016 15:17:13 -0400
Content-Disposition: inline
In-Reply-To: <1457551122-21838-2-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Wed, Mar 09, 2016 at 08:18:36PM +0100, Geert Uytterhoeven wrote:
> The Renesas R-Car System Controller provides power management for the
> CPU cores and various coprocessors, following the generic PM domain
> bindings in Documentation/devicetree/bindings/power/power_domain.txt.
> 
> This supports R-Car Gen1 (H1), Gen2, and Gen3.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - Move power area hierarchy from DT to C (cfr. DT bindings for Renesas
>     CPG/MSSR), and switch to "#power-domain-cells = <1>",
>   - Drop fallback compatibility strings, as the bindings are
>     SoC-specific,
>   - Rename from renesas,sysc-rcar.txt to renesas,rcar-sysc.txt,
> 
> v2:
>   - Add R-Car H3 (r8a7795) support,
>   - Use "renesas,<type>-sysc" instead of "renesas,sysc-<type>",
>   - Add fallback compatibility strings for R-Car Gen2 and Gen3.
> ---
>  .../bindings/power/renesas,rcar-sysc.txt           | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt

Acked-by: Rob Herring <robh@kernel.org>
