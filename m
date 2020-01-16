Return-Path: <SRS0=m8DM=3F=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA3DC33CB1
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jan 2020 06:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798392087E
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jan 2020 06:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgAPGzZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:55:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:10523 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgAPGzZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 01:55:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 22:55:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,325,1574150400"; 
   d="scan'208";a="257217569"
Received: from wanglin3-mobl.ccr.corp.intel.com ([10.255.31.165])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2020 22:55:23 -0800
Message-ID: <22cf7771952d633e36503ae3d8d462a1d40c3c90.camel@intel.com>
Subject: Re: [PATCH] thermal: int340x: processor_thermal: Add Jasper Lake
 support
From:   Zhang Rui <rui.zhang@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Swaminathan, Nivedita" <nivedita.swaminathan@intel.com>
Date:   Thu, 16 Jan 2020 14:55:55 +0800
In-Reply-To: <20191212203025.36310-1-srinivas.pandruvada@linux.intel.com>
References: <20191212203025.36310-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2019-12-12 at 12:30 -0800, Srinivas Pandruvada wrote:
> From: "Swaminathan, Nivedita" <nivedita.swaminathan@intel.com>
> 
> Added new PCI id for Jasper Lake processor thermal device.
> 
> Signed-off-by: Swaminathan, Nivedita <nivedita.swaminathan@intel.com>
> Signed-off-by: Srinivas Pandruvada <
> srinivas.pandruvada@linux.intel.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  .../thermal/intel/int340x_thermal/processor_thermal_device.c  | 4
> ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 89a015387283..b1fd34516e28 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -42,6 +42,9 @@
>  /* IceLake thermal reporting device */
>  #define PCI_DEVICE_ID_PROC_ICL_THERMAL	0x8a03
>  
> +/* JasperLake thermal reporting device */
> +#define PCI_DEVICE_ID_PROC_JSL_THERMAL	0x4503
> +
>  #define DRV_NAME "proc_thermal"
>  
>  struct power_config {
> @@ -724,6 +727,7 @@ static const struct pci_device_id
> proc_thermal_pci_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_PROC_GLK_THERMAL)},
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_PROC_ICL_THERMAL),
>  		.driver_data = (kernel_ulong_t)&rapl_mmio_hsw, },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_PROC_JSL_THERMAL)},
>  	{ 0, },
>  };
>  

