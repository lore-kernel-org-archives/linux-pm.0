From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 02/11] ARM: shmobile: r8a7740: Add missing A4S pm
 domain devices
Date: Mon, 27 Oct 2014 12:56:16 +0900
Message-ID: <20141027035615.GB31487@verge.net.au>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
 <1414063141-8856-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414063141-8856-3-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 23, 2014 at 01:18:52PM +0200, Geert Uytterhoeven wrote:
> Commit 8459293c27bcd13a ("ARM: shmobile: r8a7740: add A4S pm domain
> support") added the A4S power domain, but forgot to hook up the INTCA
> hardware block.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.

> ---
> v3:
>   - No changes,
> v2:
>   - No changes.
> ---
>  arch/arm/mach-shmobile/setup-r8a7740.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
> index 6992d4013ef013da..dbf8a93ccc4f412d 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -746,6 +746,10 @@ static void r8a7740_i2c_workaround(struct platform_device *pdev)
>  void __init r8a7740_add_standard_devices(void)
>  {
>  	static struct pm_domain_device domain_devices[] __initdata = {
> +		{ "A4S",  &irqpin0_device },
> +		{ "A4S",  &irqpin1_device },
> +		{ "A4S",  &irqpin2_device },
> +		{ "A4S",  &irqpin3_device },
>  		{ "A3SP", &scif0_device },
>  		{ "A3SP", &scif1_device },
>  		{ "A3SP", &scif2_device },
> -- 
> 1.9.1
> 
