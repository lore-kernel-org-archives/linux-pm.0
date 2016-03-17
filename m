From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Thermal/int340x/processor_thermal: Enable auxiliary DTS for
 Braswell
Date: Thu, 17 Mar 2016 20:54:47 +0300
Message-ID: <20160317175447.GA25085@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:29787 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031833AbcCQRzB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 13:55:01 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com
Cc: linux-pm@vger.kernel.org

Hello Srinivas Pandruvada,

The patch 4d0dd6c1576b: "Thermal/int340x/processor_thermal: Enable
auxiliary DTS for Braswell" from Mar 2, 2015, leads to the following
static checker warning:

	drivers/thermal/int340x_thermal/processor_thermal_device.c:380 proc_thermal_pci_probe()
	error: 'proc_priv->soc_dts' dereferencing possible ERR_PTR()

drivers/thermal/int340x_thermal/processor_thermal_device.c
   362                  /*
   363                   * Enumerate additional DTS sensors available via IOSF.
   364                   * But we are not treating as a failure condition, if
   365                   * there are no aux DTSs enabled or fails. This driver
   366                   * already exposes sensors, which can be accessed via
   367                   * ACPI/MSR. So we don't want to fail for auxiliary DTSs.
   368                   */
   369                  proc_priv->soc_dts = intel_soc_dts_iosf_init(
   370                                          INTEL_SOC_DTS_INTERRUPT_MSI, 2, 0);
   371  
   372                  if (proc_priv->soc_dts && pdev->irq) {
                            ^^^^^^^^^^^^^^^^^^
This can never be NULL.  Only a valid pointer or an error pointer.

   373                          ret = pci_enable_msi(pdev);
   374                          if (!ret) {
   375                                  ret = request_threaded_irq(pdev->irq, NULL,
   376                                                  proc_thermal_pci_msi_irq,
   377                                                  IRQF_ONESHOT, "proc_thermal",
   378                                                  pdev);
   379                                  if (ret) {
   380                                          intel_soc_dts_iosf_exit(
   381                                                          proc_priv->soc_dts);
   382                                          pci_disable_msi(pdev);
   383                                          proc_priv->soc_dts = NULL;
   384                                  }
   385                          }
   386                  } else
   387                          dev_err(&pdev->dev, "No auxiliary DTSs enabled\n");
   388          }
   389  
   390          return 0;
   391  }

regards,
dan carpenter
