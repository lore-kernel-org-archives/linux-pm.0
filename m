From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: pm: differentiate system and runtime pm for ata
 port
Date: Mon, 21 Jan 2013 15:44:35 -0500
Message-ID: <50FDA8B3.6090100@pobox.com>
References: <1346143791-2995-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1346143791-2995-1-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Jeff Wu <jeff.wu@amd.com>
List-Id: linux-pm@vger.kernel.org

On 08/28/2012 04:49 AM, Aaron Lu wrote:
> For sata port, only runtime pm needs to be taken care of;
> For IDE port, only system pm needs to be taken care of.
> Currently, we use PMSG_SUSPEND for both system suspend and runtime
> suspend and PMSG_ON for both system resume and runtime resume.
>
> Change this by using PMSG_AUTO_SUSPEND for runtime suspend and
> PMSG_AUTO_RESUME for runtime resume.
>
> The ata_acpi_set_state is modified accordingly. And the sata case and
> pata case is seperated for easy understanding.
>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>   drivers/ata/libata-acpi.c | 83 ++++++++++++++++++++++++++++++++---------------
>   drivers/ata/libata-core.c | 22 +++++++++----
>   drivers/ata/libata-eh.c   |  9 ++---
>   3 files changed, 78 insertions(+), 36 deletions(-)


Can you rediff this on top of libata-dev.git #upstream?



