From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-acpi.c: fix copy and paste mistake in ata_acpi_register_power_resource
Date: Mon, 04 Mar 2013 17:15:04 -0500
Message-ID: <51351CE8.5020500@pobox.com>
References: <2508494.4AbRYXD1du@vostro.rjw.lan> <1362136602-30327-1-git-send-email-linux@eikelenboom.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1362136602-30327-1-git-send-email-linux@eikelenboom.it>
Sender: linux-ide-owner@vger.kernel.org
To: Sander Eikelenboom <linux@eikelenboom.it>
Cc: rjw@sisk.pl, aaron.lu@intel.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/01/2013 06:16 AM, Sander Eikelenboom wrote:
> Fix a copy and paste mistake introduced in:
>
> commit bc9b6407bd6df3ab7189e5622816bbc11ae9d2d8
> "ACPI / PM: Rework the handling of devices depending on power resources"
>
> Signed-off-by: Sander Eikelenboom <linux@eikelenboom.it>
> ---
>   drivers/ata/libata-acpi.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

applied



