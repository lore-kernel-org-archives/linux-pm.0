From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] irqchip: mxs: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
Date: Sat, 31 Dec 2016 19:41:46 +0000
Message-ID: <20161231194146.GH30137@io.lakedaemon.net>
References: <1482863397-11400-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1482863397-11400-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Oleksij Rempel <linux@rempel-privat.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, Lothar =?utf-8?Q?Wa=C3=9Fmann?= <lw@karo-electronics.de>
List-Id: linux-pm@vger.kernel.org

Hi Stefan,

On Tue, Dec 27, 2016 at 06:29:57PM +0000, Stefan Wahren wrote:
> The ICOLL controller doesn't provide any facility to configure the
> wakeup sources. That's the reason why this implementation lacks
> the irq_set_wake implementation. But this prevent us from properly
> entering power management states like "suspend to idle".
> 
> So enable the flags IRQCHIP_SKIP_SET_WAKE and
> IRQCHIP_MASK_ON_SUSPEND to let the irqchip core allows and handles
> the power management.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/irqchip/irq-mxs.c |    4 ++++
>  1 file changed, 4 insertions(+)

Applied to irqchip/urgent with Fabio's Reviewed-by.

thx,

Jason.
