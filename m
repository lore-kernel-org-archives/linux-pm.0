From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Tue, 17 Aug 2010 14:09:33 +0200
Message-ID: <4C6A7BFD.1070604@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201008171319.25080.rjw@sisk.pl> <4C6A7281.3030804@gmail.com> <201008171410.21382.stephan.diestelhorst@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <201008171410.21382.stephan.diestelhorst@amd.com>
Sender: linux-ide-owner@vger.kernel.org
To: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On 08/17/2010 02:10 PM, Stephan Diestelhorst wrote:
> If you want me to test anything... let me know. Since I do not know
> much about the ATA code, I do not know what to change where. (A simple
> grep for sd_suspend in drivers/ata didn't turn up anything.)

Oh, sure, the following should be enough.  Thanks.

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 8802e48..892ccc7 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2456,6 +2456,8 @@ static int sd_suspend(struct device *dev, pm_message_t mesg)
 	struct scsi_disk *sdkp = scsi_disk_get_from_dev(dev);
 	int ret = 0;

+	return 0;
+
 	if (!sdkp)
 		return 0;	/* this can happen */

-- 
tejun
