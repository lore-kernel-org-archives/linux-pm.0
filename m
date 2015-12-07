From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/6] arm64: renesas: r8a7795: Add L2 cache-controller
 nodes
Date: Mon, 7 Dec 2015 19:03:55 +0000
Message-ID: <20151207190355.GE28024@leverpostej>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
 <1449512659-16688-7-git-send-email-geert+renesas@glider.be>
 <5665D4C7.1050705@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5665D4C7.1050705@arm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lina Iyer <lina.iyer@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 07, 2015 at 06:49:43PM +0000, Sudeep Holla wrote:
> 
> On 07/12/15 18:24, Geert Uytterhoeven wrote:
> >+	L2_CA57: cache-controller@0 {
> >+		compatible = "cache";
> >+		arm,data-latency = <4 4 1>;
> >+		arm,tag-latency = <3 3 3>;
> 
> Interesting, only PL2xx/3xx cache controller driver reads this from the
> DT and configures the controller. The integrated L2 found in
> A15/A7/A57/A53 needs doesn't make use of these values from the DT.

These properties seem to be from l2cc.txt, which really only corresponds
to PL210/PL220/PL310 (and variants) and isn't as generic as it sounds.

I don't see that these are necessary at all.

Thanks,
Mark.
