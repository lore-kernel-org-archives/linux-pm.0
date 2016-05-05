From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/6] arm: dt: bcm23550: Add device tree files
Date: Thu, 05 May 2016 23:05:04 +0200
Message-ID: <9191808.kbIrFQuH7z@wuerfel>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
 <1462481334-8943-7-git-send-email-chris.brand@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462481334-8943-7-git-send-email-chris.brand@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Brand <chris.brand@broadcom.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Scott Branden <sbranden@broadcom.com>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Ray Jui <rjui@broadcom.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Raymond Ngun <raymond.ngun@broadcom.com>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Markus Mayer <markus.mayer@broadcom.com>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thursday 05 May 2016 13:48:54 Chris Brand wrote:
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200n8";
> +       };
> +
> 

Can you move this into the .dts file, and add a stdout-path
property to make earlycon work?

	Arnd
