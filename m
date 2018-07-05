From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date: Thu, 5 Jul 2018 11:34:59 +0200
Message-ID: <CAJZ5v0guCPET3gM-G_NAM-BjER2D3yW2i_CwR-5sHyNzCQ6R+Q@mail.gmail.com>
References: <s5hk1qaf9hv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk1qaf9hv.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?Q?Thomas_H=C3=A4nig?= <haenig@cosifan.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Jul 5, 2018 at 9:05 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Hi,
>
> we've got a regression report since 4.17 about the behavior of
> power-off with the power button.  When a machine is powered off with
> the power button on desktop, it reboots after a few seconds instead of
> power down.
>
> The manual power down via "systemctl poweroff" works fine, so it's
> possibly some spurious wakeup by the power button action, and some
> ACPI-related change is suspected.
> The regression still remains in 4.18-rc3.

There are only a few ACPI commits directly related to power management
between 4.16 and 4.17 and none of them looks particularly suspicious.

It looks like the power button state may not be cleared sufficiently
after it's been pressed which is now visible for some reason.

How does the button poweroff work, exactly?  I guess the event is
collected by a user space demon which then triggers power of via sysfs
or similar?

Thanks,
Rafael
