From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 1/5] clk: shmobile: rcar-gen2: Add CPG Clock Domain
 support
Date: Wed, 25 Mar 2015 10:04:40 +0900
Message-ID: <20150325010440.GC1767@verge.net.au>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
 <1426708017-28885-2-git-send-email-geert+renesas@glider.be>
 <20150324230036.7930.50037@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150324230036.7930.50037@quantum>
Sender: linux-sh-owner@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Mike,

On Tue, Mar 24, 2015 at 04:00:36PM -0700, Michael Turquette wrote:
> Quoting Geert Uytterhoeven (2015-03-18 12:46:53)
> > Add Clock Domain support to the R-Car Gen2 Clock Pulse Generator (CPG)
> > driver using the generic PM Domain.  This allows to power-manage the
> > module clocks of SoC devices that are part of the CPG Clock Domain using
> > Runtime PM, or for system suspend/resume.
> > 
> > SoC devices that are part of the CPG Clock Domain and can be
> > power-managed through their primary clock should be tagged in DT with a
> > proper "power-domains" property.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Looks good to me. Which tree do you want this patch to go through?

My tree seems reasonable from my point of view.
Though at this point it would be targeted at v4.2.
