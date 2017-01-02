From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / docs: Drop confusing kernel-doc references from infrastructure.rst
Date: Mon, 02 Jan 2017 23:05:31 +0100
Message-ID: <1866121.f9dSvTNiL5@aspire.rjw.lan>
References: <1637935.8QKVTKQPm8@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1637935.8QKVTKQPm8@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, December 19, 2016 09:36:39 PM Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The references to drivers/base/power/main.c and
> drivers/acpi/scan.c from Documentation/driver-api/infrastructure.rst
> are confusing.  They both cause descriptions of functions that are
> not relevant to device drivers at all to be generated and none of
> them is sufficient to cover the API in a meaningful way.
> 
> Drop them for now.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I'd like this to go into 4.10.

Are there any objections here?

> ---
>  Documentation/driver-api/infrastructure.rst |   15 ---------------
>  1 file changed, 15 deletions(-)
> 
> Index: linux-pm/Documentation/driver-api/infrastructure.rst
> ===================================================================
> --- linux-pm.orig/Documentation/driver-api/infrastructure.rst
> +++ linux-pm/Documentation/driver-api/infrastructure.rst
> @@ -55,21 +55,6 @@ Device Drivers DMA Management
>  .. kernel-doc:: drivers/base/dma-mapping.c
>     :export:
>  
> -Device Drivers Power Management
> --------------------------------
> -
> -.. kernel-doc:: drivers/base/power/main.c
> -   :export:
> -
> -Device Drivers ACPI Support
> ----------------------------
> -
> -.. kernel-doc:: drivers/acpi/scan.c
> -   :export:
> -
> -.. kernel-doc:: drivers/acpi/scan.c
> -   :internal:
> -
>  Device drivers PnP support
>  --------------------------
>  
> 
> --

Thanks,
Rafael
