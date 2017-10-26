From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH v8 4/7] of/irq: Adjust of pci irq parsing for multiple interrupts
Date: Thu, 26 Oct 2017 15:02:34 -0500
Message-ID: <CAL_Jsq+HYL0VPpzD=BYKMJ5-kuxB2Cn5tUF5RRcczUv_fdv_9w@mail.gmail.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com> <20171026132840.20946-5-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932394AbdJZUC4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Oct 2017 16:02:56 -0400
In-Reply-To: <20171026132840.20946-5-jeffy.chen@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Shawn Lin <shawn.lin@rock-chips.com>, Brian Norris <briannorris@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>, Frank Rowand <frowand.list@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Oct 26, 2017 at 8:28 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Currently we are considering the first irq as the PCI interrupt pin,
> but a pci device may have multiple interrupts(e.g. PCIe WAKE# pin).
>
> Only parse the PCI interrupt pin when the irq is unnamed or named as
> "pci".

Why do you need this patch? You're moving the wakeup handling from the
PCI device to the bridge. The bridge device is not PCI interrupts, but
a platform device so this function doesn't matter.

Rob
