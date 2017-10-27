From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [RFC PATCH v8 4/7] of/irq: Adjust of pci irq parsing for multiple
 interrupts
Date: Fri, 27 Oct 2017 10:05:03 +0800
Message-ID: <59F2944F.9060208@rock-chips.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com> <20171026132840.20946-5-jeffy.chen@rock-chips.com> <CAL_Jsq+HYL0VPpzD=BYKMJ5-kuxB2Cn5tUF5RRcczUv_fdv_9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:59553 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbdJ0CFY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2017 22:05:24 -0400
In-Reply-To: <CAL_Jsq+HYL0VPpzD=BYKMJ5-kuxB2Cn5tUF5RRcczUv_fdv_9w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Shawn Lin <shawn.lin@rock-chips.com>, Brian Norris <briannorris@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>, Frank Rowand <frowand.list@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Rob,

On 10/27/2017 04:02 AM, Rob Herring wrote:
> Why do you need this patch? You're moving the wakeup handling from the
> PCI device to the bridge. The bridge device is not PCI interrupts, but
> a platform device so this function doesn't matter.
>

because it's possible we have multiple PCI devices with individual WAKE# 
interrupt.

so Brian suggested we may need to support both of PCI device wakeup 
handling and the bridge wakeup handling in the pci core(as the ACPI) :)

> Rob
>
>
>
