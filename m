From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] SCSI: remove dev->power.power_state from
 mesh driver
Date: Fri, 23 May 2008 16:53:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805231651440.3106-100000__7785.53638742796$1211576110$gmane$org@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0803071118040.4398-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803071118040.4398-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Paul Mackerras <paulus@au.ibm.com>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

There hasn't been any comment on the patch below, and it hasn't been 
applied yet.  Do I need to submit it somewhere else?

Alan Stern


On Fri, 7 Mar 2008, Alan Stern wrote:

> power.power_state is scheduled for removal.  This patch (as1055)
> removes all uses of that field from the SCSI mesh driver.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> CC: Paul Mackerras <paulus@au.ibm.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ---
> 
> Index: usb-2.6/drivers/scsi/mesh.c
> ===================================================================
> --- usb-2.6.orig/drivers/scsi/mesh.c
> +++ usb-2.6/drivers/scsi/mesh.c
> @@ -1765,7 +1765,7 @@ static int mesh_suspend(struct macio_dev
>  	default:
>  		return 0;
>  	}
> -	if (mesg.event == mdev->ofdev.dev.power.power_state.event)
> +	if (ms->phase == sleeping)
>  		return 0;
>  
>  	scsi_block_requests(ms->host);
> @@ -1780,8 +1780,6 @@ static int mesh_suspend(struct macio_dev
>  	disable_irq(ms->meshintr);
>  	set_mesh_power(ms, 0);
>  
> -	mdev->ofdev.dev.power.power_state = mesg;
> -
>  	return 0;
>  }
>  
> @@ -1790,7 +1788,7 @@ static int mesh_resume(struct macio_dev 
>  	struct mesh_state *ms = (struct mesh_state *)macio_get_drvdata(mdev);
>  	unsigned long flags;
>  
> -	if (mdev->ofdev.dev.power.power_state.event == PM_EVENT_ON)
> +	if (ms->phase != sleeping)
>  		return 0;
>  
>  	set_mesh_power(ms, 1);
> @@ -1801,8 +1799,6 @@ static int mesh_resume(struct macio_dev 
>  	enable_irq(ms->meshintr);
>  	scsi_unblock_requests(ms->host);
>  
> -	mdev->ofdev.dev.power.power_state.event = PM_EVENT_ON;
> -
>  	return 0;
>  }
