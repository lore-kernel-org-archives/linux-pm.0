From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: arm: atmel: add missing samx7 to reset
 controller
Date: Mon, 21 Jan 2019 19:05:28 -0600
Message-ID: <20190122010528.GA20975@bogus>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <b073b46ab85e9c855640e674f12f2a0801876140.1547629763.git.nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b073b46ab85e9c855640e674f12f2a0801876140.1547629763.git.nicolas.ferre@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 16 Jan 2019 10:57:37 +0100, Nicolas Ferre wrote:
> Add this missing compatibility string to the Reset Controller
> compatible string chip list.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
