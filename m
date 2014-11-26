From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 9/9] usb: {ohci,ehci}-platform: Use new OF big-endian
 helper function
Date: Wed, 26 Nov 2014 10:14:48 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411261013340.1322-100000@iolanthe.rowland.org>
References: <1416962994-27095-10-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55943 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753411AbaKZPOt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 10:14:49 -0500
In-Reply-To: <1416962994-27095-10-git-send-email-cernekee@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, arnd@arndb.de, linux@prisktech.co.nz, gregkh@linuxfoundation.org, f.fainelli@gmail.com, grant.likely@linaro.org, robh+dt@kernel.org, computersforpeace@gmail.com, marc.ceeeee@gmail.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mips@linux-mips.org

On Tue, 25 Nov 2014, Kevin Cernekee wrote:

> This handles the existing "big-endian" case, and in addition, it also does
> the right thing when "native-endian" is specified.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt | 2 ++
>  Documentation/devicetree/bindings/usb/usb-ohci.txt | 2 ++
>  drivers/usb/host/ehci-platform.c                   | 2 +-
>  drivers/usb/host/ohci-platform.c                   | 2 +-
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 43c1a4e..9505c31 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -12,6 +12,8 @@ Optional properties:
>   - big-endian-regs : boolean, set this for hcds with big-endian registers
>   - big-endian-desc : boolean, set this for hcds with big-endian descriptors
>   - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
> + - native-endian : boolean, enables big-endian-regs + big-endian-desc
> +   iff the kernel was compiled for big endian

Is this really a property of the hardware?  It appears to depend on the 
kernel configuration.  As such, is it appropriate for DT?

Alan Stern

