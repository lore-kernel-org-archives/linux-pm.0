From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] irqchip: renesas-irqc: Add wake-up support
Date: Thu, 2 Apr 2015 23:32:22 +0000
Message-ID: <20150402233222.GK24598@io.lakedaemon.net>
References: <1427889606-18671-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427889606-18671-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 01, 2015 at 02:00:06PM +0200, Geert Uytterhoeven wrote:
> The IRQC module clock is managed through Runtime PM and PM Domains.
> If wake-up is enabled, this clock must not be disabled during system
> suspend.
> 
> Hence implement irq_chip.irq_set_wake(), which increments/decrements the
> clock's enable_count when needed.
> 
> This fixes wake-up by gpio-keys on r8a73a4/ape6evm.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Against irqchip/renesas
> 
>  drivers/irqchip/irq-renesas-irqc.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)

Applied to irqchip/renesas with Simon's Reviewed-by.

thx,

Jason.
