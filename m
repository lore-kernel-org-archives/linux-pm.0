From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] [libata] Avoid specialized TLA's in ZPODD's Kconfig
Date: Fri, 01 Mar 2013 17:10:55 +0400
Message-ID: <5130A8DF.7080709@cogentembedded.com>
References: <1663657.ypAtqGpGAq@vostro.rjw.lan> <1781256.mPQbtiUPYR@vostro.rjw.lan> <CA+55aFyzjN_wMH+2RCEA+aNLY0Z7fn4YU7VOtTALbgngn1+vCw@mail.gmail.com> <2223198.XmyRLgb3Gv@vostro.rjw.lan> <20130226161049.GA9303@kahuna> <CA+55aFy24fp+9zXiDmAgvsz6YvWQh2L0BAJ2hAhF7cNSdyMd8w@mail.gmail.com> <CA+55aFyu5woJsH2y3y=w4UFneOG8hKz_cLXgZQbJzn5asn8=hQ@mail.gmail.com> <20130226163712.GA30433@htj.dyndns.org> <CA+55aFyFRbMX9G_0Mv0nUZgw9mHAPzE0zCw5mCSbGG_r1diFHg@mail.gmail.com> <20130226165813.GB30433@htj.dyndns.org> <512CF809.8010102@pobox.com> <5130052E.9070403@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5130052E.9070403@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello.

On 01-03-2013 5:32, Aaron Lu wrote:

> ODD is not a common TLA for non-ATA people so they will get confused
> by its meaning when they are configuring the kernel. This patch fixed
> this problem by using ODD only after stating what it is.

> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>   drivers/ata/Kconfig | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 3e751b7..d7d210e 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -59,15 +59,16 @@ config ATA_ACPI
>   	  option libata.noacpi=1
>
>   config SATA_ZPODD
> -	bool "SATA Zero Power ODD Support"
> +	bool "SATA Zero Power Optical Disc Drive(ZPODD) support"

    Need a space before open paren.

>   	depends on ATA_ACPI
>   	default n
>   	help
> -	  This option adds support for SATA ZPODD. It requires both
> -	  ODD and the platform support, and if enabled, will automatically
> -	  power on/off the ODD when certain condition is satisfied. This
> -	  does not impact user's experience of the ODD, only power is saved
> -	  when ODD is not in use(i.e. no disc inside).
> +	  This option adds support for SATA Zero Power Optical Disc
> +	  Drive(ZPODD). It requires both the ODD and the platform

    Same here.

> +	  support, and if enabled, will automatically power on/off the
> +	  ODD when certain condition is satisfied. This does not impact
> +	  end user's experience of the ODD, only power is saved when
> +	  the ODD is not in use(i.e. no disc inside).

   And here.

MBR, Sergei
