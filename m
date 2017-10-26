From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH v8 7/7] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Date: Thu, 26 Oct 2017 07:42:22 -0700
Message-ID: <20171026144221.GF21504@atomide.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
 <20171026132840.20946-8-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:45748 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932255AbdJZOmZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Oct 2017 10:42:25 -0400
Content-Disposition: inline
In-Reply-To: <20171026132840.20946-8-jeffy.chen@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, linux-pm@vger.kernel.org, shawn.lin@rock-chips.com, briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org, linux-pci@vger.kernel.org

* Jeffy Chen <jeffy.chen@rock-chips.com> [171026 06:31]:
> Add pci-of.c to handle the PCIe WAKE# interrupt.
> 
> Also use the dedicated wakeirq infrastructure to simplify it.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Thanks for doing this, looks good to me from wakeirq point of view:

Acked-by: Tony Lindgren <tony@atomide.com>
