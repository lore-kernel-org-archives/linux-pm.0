From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] Thermal/int340x/processor_thermal: Enable auxiliary DTS
 for Braswell
Date: Tue, 11 Apr 2017 13:46:26 +0300
Message-ID: <20170411104626.GA2073@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35090 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754456AbdDKKqp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 06:46:45 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com
Cc: linux-pm@vger.kernel.org

Hello Srinivas Pandruvada,

The patch 4d0dd6c1576b: "Thermal/int340x/processor_thermal: Enable
auxiliary DTS for Braswell" from Mar 2, 2015, leads to the following
static checker warning:

	drivers/thermal/int340x_thermal/processor_thermal_device.c:419 proc_thermal_pci_probe()
	warn: 'proc_priv->soc_dts' is an error pointer or valid

drivers/thermal/int340x_thermal/processor_thermal_device.c
   408          if (pdev->device == PCI_DEVICE_ID_PROC_BSW_THERMAL) {
   409                  /*
   410                   * Enumerate additional DTS sensors available via IOSF.
   411                   * But we are not treating as a failure condition, if
   412                   * there are no aux DTSs enabled or fails. This driver
   413                   * already exposes sensors, which can be accessed via
   414                   * ACPI/MSR. So we don't want to fail for auxiliary DTSs.
   415                   */
   416                  proc_priv->soc_dts = intel_soc_dts_iosf_init(
                                             ^^^^^^^^^^^^^^^^^^^^^^^
Uses error pointers, never returns NULL.

   417                                          INTEL_SOC_DTS_INTERRUPT_MSI, 2, 0);
   418  
   419                  if (proc_priv->soc_dts && pdev->irq) {
   420                          ret = pci_enable_msi(pdev);
   421                          if (!ret) {
   422                                  ret = request_threaded_irq(pdev->irq, NULL,
   423                                                  proc_thermal_pci_msi_irq,
   424                                                  IRQF_ONESHOT, "proc_thermal",
   425                                                  pdev);
   426                                  if (ret) {
   427                                          intel_soc_dts_iosf_exit(
   428                                                          proc_priv->soc_dts);
   429                                          pci_disable_msi(pdev);
   430                                          proc_priv->soc_dts = NULL;
   431                                  }
   432                          }
   433                  } else
   434                          dev_err(&pdev->dev, "No auxiliary DTSs enabled\n");
   435          }
   436  
   437          return 0;
   438  }


regards,
dan carpenter
