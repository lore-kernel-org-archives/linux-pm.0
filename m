From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/4] PCI: Avoid unnecessary resume after direct-complete
Date: Wed, 14 Sep 2016 02:29:12 +0200
Message-ID: <1727866.mELYGZAK8C@vostro.rjw.lan>
References: <cover.1472554278.git.lukas@wunner.de> <4935437e0bfbab9079db2c8b1fbac66cef7dc569.1472554278.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4935437e0bfbab9079db2c8b1fbac66cef7dc569.1472554278.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>, Andreas Noever <andreas.noever@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 31, 2016 08:15:18 AM Lukas Wunner wrote:
> Commit 58a1fbbb2ee8 ("PM / PCI / ACPI: Kick devices that might have been
> reset by firmware") added a runtime resume for devices that were runtime
> suspended when the system entered sleep.
> 
> The motivation was that devices might be in a reset-power-on state after
> waking from system sleep, so their power state as perceived by Linux
> (stored in pci_dev->current_state) would no longer reflect reality.
> By resuming such devices, we allow them to return to a low-power state
> via autosuspend and also bring their current_state in sync with reality.

Not only that.

It allows those devices to respond more timely to user space requests
occuring right after resume.

Those user space requests often occur sequentially (read from device A,
write to device B, read from device C, write to device D, for example)
and without that pre-emptive resume each of them needs to wait for another
device to (runtime-)resume which results in quite annoying latencies
observable by users.

> However for devices that are *not* in a reset-power-on state, doing an
> unconditional resume wastes energy.

It may or may not waste it and this really is a tradeoff.

Thanks,
Rafael
