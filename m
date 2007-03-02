From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2 -stable] libata: add missing PM callbacks
Date: Fri, 2 Mar 2007 17:45:30 +0900
Message-ID: <20070302084530.GN20322@htj.dyndns.org>
References: <20061122172841.0b90f042@localhost.localdomain> <Pine.LNX.4.60.0702262150460.5079@poirot.grange> <Pine.LNX.4.60.0702282201250.8832@poirot.grange> <Pine.LNX.4.60.0703012305030.7351@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0703012305030.7351@poirot.grange>
Sender: linux-ide-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-pm@lists.osdl.org, linux-ide@vger.kernel.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

Some LLDs were missing scsi device PM callbacks while having host/port
suspend support.  Add missing ones.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This should fix the problem you're seeing on sil680.  These patches
are against 2.6.20.1.  Patches for libata-dev#upstream is separately
posted to linux-ide in the following thread.

  http://thread.gmane.org/gmane.linux.ide/16475

 drivers/ata/pata_jmicron.c |    4 ++++
 drivers/ata/pata_sil680.c  |    4 ++++
 2 files changed, 8 insertions(+)

Index: work1/drivers/ata/pata_sil680.c
===================================================================
--- work1.orig/drivers/ata/pata_sil680.c
+++ work1/drivers/ata/pata_sil680.c
@@ -226,6 +226,10 @@ static struct scsi_host_template sil680_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static struct ata_port_operations sil680_port_ops = {
Index: work1/drivers/ata/pata_jmicron.c
===================================================================
--- work1.orig/drivers/ata/pata_jmicron.c
+++ work1/drivers/ata/pata_jmicron.c
@@ -137,6 +137,10 @@ static struct scsi_host_template jmicron
 	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static const struct ata_port_operations jmicron_ops = {
