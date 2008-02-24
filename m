From: Jeff Garzik <jeff@garzik.org>
Subject: Re: power_state: get rid of write-only variable in SATA
Date: Sun, 24 Feb 2008 00:29:20 -0500
Message-ID: <47C100B0.1040408@garzik.org>
References: <20080221125652.GA23548@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759035AbYBXF3g@vger.kernel.org>
In-Reply-To: <20080221125652.GA23548@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> power_state is scheduled for removal, and libata uses it in write-only
> mode. Remove it.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index b4985bc..a31572d 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6542,8 +6542,6 @@ int ata_host_suspend(struct ata_host *ho
>  	ata_lpm_enable(host);
>  
>  	rc = ata_host_request_pm(host, mesg, 0, ATA_EHI_QUIET, 1);
> -	if (rc == 0)
> -		host->dev->power.power_state = mesg;
>  	return rc;
>  }
>  
> @@ -6562,7 +6560,6 @@ void ata_host_resume(struct ata_host *ho
>  {
>  	ata_host_request_pm(host, PMSG_ON, ATA_EH_SOFTRESET,
>  			    ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET, 0);
> -	host->dev->power.power_state = PMSG_ON;
>  

applied
