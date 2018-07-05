From: =?UTF-8?Q?Thomas_H=c3=a4nig?= <haenig@cosifan.de>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date: Thu, 5 Jul 2018 11:58:15 +0200
Message-ID: <275e2bd6-87aa-bd20-1f79-0830da86f6d0@cosifan.de>
References: <s5hk1qaf9hv.wl-tiwai@suse.de>
 <CAJZ5v0guCPET3gM-G_NAM-BjER2D3yW2i_CwR-5sHyNzCQ6R+Q@mail.gmail.com>
 <s5hk1qaui3w.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk1qaui3w.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am 05.07.2018 um 11:50 schrieb Takashi Iwai:
> Usually X desktop environment receives an input event from the ACPI
> power button input device, and deals the event accordingly depending
> on the setup.  The power-down behavior itself should be equivalent
> with "systemctl poweroff" or such.
The behaviour occurs even when booting into runlevel 3 /
multi-user.target so if no X11 or graphical DE is involved


Thomas
