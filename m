From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for
 Broadcom STB SoCs
Date: Fri, 11 Nov 2016 15:52:58 +0300
Message-ID: <20161111114917.GA3964@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:30888 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756555AbcKKMxM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 07:53:12 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mmayer@broadcom.com
Cc: linux-pm@vger.kernel.org

Hello Markus Mayer,

The patch de322e085995: "cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq
driver for Broadcom STB SoCs" from Oct 27, 2016, leads to the
following static checker warning:

	drivers/cpufreq/brcmstb-avs-cpufreq.c:509 brcm_avs_get_freq_table()
	error: buffer overflow 'table' 5 <= 5

drivers/cpufreq/brcmstb-avs-cpufreq.c
   485  static struct cpufreq_frequency_table *
   486  brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
   487  {
   488          struct cpufreq_frequency_table *table;
   489          unsigned int pstate;
   490          int i, ret;
   491  
   492          /* Remember P-state for later */
   493          ret = brcm_avs_get_pstate(priv, &pstate);
   494          if (ret)
   495                  return ERR_PTR(ret);
   496  
   497          table = devm_kzalloc(dev, (AVS_PSTATE_MAX + 1) * sizeof(*table),
   498                               GFP_KERNEL);
   499          if (!table)
   500                  return ERR_PTR(-ENOMEM);
   501  
   502          for (i = AVS_PSTATE_P0; i <= AVS_PSTATE_MAX; i++) {

I guess this should be < instead of <=.

   503                  ret = brcm_avs_set_pstate(priv, i);
   504                  if (ret)
   505                          return ERR_PTR(ret);
   506                  table[i].frequency = brcm_avs_get_frequency(priv->base);
   507                  table[i].driver_data = i;
   508          }
   509          table[i].frequency = CPUFREQ_TABLE_END;

Otherwise we're always writing one element beyond the end of the array
here.

   510  
   511          /* Restore P-state */
   512          ret = brcm_avs_set_pstate(priv, pstate);
   513          if (ret)
   514                  return ERR_PTR(ret);
   515  
   516          return table;
   517  }

regards,
dan carpenter
