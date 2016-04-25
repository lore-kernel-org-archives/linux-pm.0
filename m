From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 19/41] Documentation: dt: opp: fix spelling mistake
Date: Mon, 25 Apr 2016 08:50:53 -0500
Message-ID: <20160425135053.GA9061@rob-hp-laptop>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461543878-3639-20-git-send-email-eric@engestrom.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461543878-3639-20-git-send-email-eric@engestrom.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Engestrom <eric@engestrom.ch>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 25, 2016 at 01:24:16AM +0100, Eric Engestrom wrote:
> Signed-off-by: Eric Engestrom <eric@engestrom.ch>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 601256f..ee91cbd 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -45,7 +45,7 @@ Devices supporting OPPs must set their "operating-points-v2" property with
>  phandle to a OPP table in their DT node. The OPP core will use this phandle to
>  find the operating points for the device.
>  
> -If required, this can be extended for SoC vendor specfic bindings. Such bindings
> +If required, this can be extended for SoC vendor specific bindings. Such bindings
>  should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
>  and should have a compatible description like: "operating-points-v2-<vendor>".
>  
> -- 
> 2.8.0
> 
