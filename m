From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/4] Documentation: devicetree: add binding for
 Broadcom STB AVS TMON
Date: Thu, 17 Aug 2017 10:10:31 -0500
Message-ID: <20170817151031.yh2wlpyvrp2qvhac@rob-hp-laptop>
References: <20170809220257.4234-1-code@mmayer.net>
 <20170809220257.4234-2-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170809220257.4234-2-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Doug Berger <opendmb@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.o>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 09, 2017 at 03:02:54PM -0700, Markus Mayer wrote:
> From: Brian Norris <computersforpeace@gmail.com>
> 
> Add binding for Broadcom STB thermal.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  .../devicetree/bindings/thermal/brcm,avs-tmon.txt    | 20 ++++++++++++++++++++
>  MAINTAINERS                                          |  8 ++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt

Acked-by: Rob Herring <robh@kernel.org>
