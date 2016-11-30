From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] PM / Domains: Do not print PM domain add error message
 if EPROBE_DEFER
Date: Wed, 30 Nov 2016 13:41:48 +0100
Message-ID: <20161130124145.GA22147@verge.net.au>
References: <1480508696-19294-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55065 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756551AbcK3Ml4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 07:41:56 -0500
Content-Disposition: inline
In-Reply-To: <1480508696-19294-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Wed, Nov 30, 2016 at 01:24:56PM +0100, Geert Uytterhoeven wrote:
> EPROBE_DEFER is not an error, hence printing an error message like
> 
>     renesas_irqc e61c0000.interrupt-controller: failed to add to PM domain always-on: -517
> 
> may confuse the user.
> 
> Suppress the error message in case of EPROBE_DEFER to fix this.
> 
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
