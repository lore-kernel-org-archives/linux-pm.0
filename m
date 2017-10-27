From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [RFC PATCH v8 7/7] PCI / PM: Add support for the PCIe WAKE# signal
 for OF
Date: Fri, 27 Oct 2017 15:32:52 +0800
Message-ID: <59F2E124.5060209@rock-chips.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com> <20171026132840.20946-8-jeffy.chen@rock-chips.com> <20171027055529.GB85582@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.138]:57861 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdJ0Hc7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Oct 2017 03:32:59 -0400
In-Reply-To: <20171027055529.GB85582@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, linux-pm@vger.kernel.org, tony@atomide.com, shawn.lin@rock-chips.com, rjw@rjwysocki.net, dianders@chromium.org, linux-pci@vger.kernel.org

Hi Brian,

On 10/27/2017 01:55 PM, Brian Norris wrote:
> One reason this series is failing for me: the above is failing with
> -EINVAL -- it seems like no one set the 'can_wakeup' flag for the
> Marvell Wifi card I'm using. It seems like we probably*should*  be
> calling device_set_wakeup_capable() from your new setup method, to say
> that we're capable of wakeup. The PCI PME code does this already, which
> seems to make sense. There are also some network drivers that do it too
> (e.g., ath10k), but not all.
>
right, thanks for noticing, will fix it in the new version...

and Sinan suggested to separate of code and wakeirq handling, would it 
make sense to rewrite this as pci-wakeirq.c(platform_pm_ops based on 
irq), and move of parse code into drivers/of/(maybe into 
of_irq_parse_pci()'s PCI interrupt parsing code)?

> Brian
>
