From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v6 5/6] mfd: intel_soc_pmic_bxtwc: Use chained IRQs for
 second level IRQ chips
Date: Tue, 6 Jun 2017 12:29:03 +0300
Message-ID: <20170606092903.GK26659@kuha.fi.intel.com>
References: <cover.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <9881880e5aac28a53398b40db468c704763e941a.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4739 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbdFFJbY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jun 2017 05:31:24 -0400
Content-Disposition: inline
In-Reply-To: <9881880e5aac28a53398b40db468c704763e941a.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: gnurou@gmail.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org, platform-driver-x86@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com

On Mon, Jun 05, 2017 at 12:08:05PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Whishkey cove PMIC has support to mask/unmask interrupts at two levels.
> At first level we can mask/unmask interrupt domains like TMU, GPIO, ADC,
> CHGR, BCU THERMAL and PWRBTN and at second level, it provides facility
> to mask/unmask individual interrupts belong each of this domain. For
> example, in case of TMU, at first level we have TMU interrupt domain,
> and at second level we have two interrupts, wake alarm, system alarm that
> belong to the TMU interrupt domain.
> 
> Currently, in this driver all first level IRQs are registered as part of
> IRQ chip(bxtwc_regmap_irq_chip). By default, after you register the IRQ
> chip from your driver, all IRQs in that chip will masked and can only be
> enabled if that IRQ is requested using request_irq() call. This is the
> default Linux IRQ behavior model. And whenever a dependent device that
> belongs to PMIC requests only the second level IRQ and not explicitly
> unmask the first level IRQ, then in essence the second level IRQ will
> still be disabled. For example, if TMU device driver request wake_alarm
> IRQ and not explicitly unmask TMU level 1 IRQ then according to the default
> Linux IRQ model,  wake_alarm IRQ will still be disabled. So the proper
> solution to fix this issue is to use the chained IRQ chip concept. We
> should chain all the second level chip IRQs to the corresponding first
> level IRQ. To do this, we need to create separate IRQ chips for every
> group of second level IRQs.
> 
> In case of TMU, when adding second level IRQ chip, instead of using PMIC
> IRQ we should use the corresponding first level IRQ. So the following
> code will change from
> 
> ret = regmap_add_irq_chip(pmic->regmap, pmic->irq, ...)
> 
> to,
> 
> virq = regmap_irq_get_virq(&pmic->irq_chip_data, BXTWC_TMU_LVL1_IRQ);
> 
> ret = regmap_add_irq_chip(pmic->regmap, virq, ...)
> 
> In case of Whiskey Cove Type-C driver, Since USBC IRQ is moved under
> charger level2 IRQ chip. We should use charger IRQ chip(irq_chip_data_chgr)
> to get the USBC virtual IRQ number.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

For the typec_wcove.c part:

Revieved-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
