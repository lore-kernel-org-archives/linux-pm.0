From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date: Thu, 05 Jul 2018 12:16:13 +0200
Message-ID: <4159650.gQjFNdt1WI@aspire.rjw.lan>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <275e2bd6-87aa-bd20-1f79-0830da86f6d0@cosifan.de> <s5hh8leuhms.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hh8leuhms.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Thomas H4nig <haenig@cosifan.de>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 5, 2018 12:00:27 PM CEST Takashi Iwai wrote:
> On Thu, 05 Jul 2018 11:58:15 +0200,
> Thomas H4nig wrote:
> > 
> > Am 05.07.2018 um 11:50 schrieb Takashi Iwai:
> > > Usually X desktop environment receives an input event from the ACPI
> > > power button input device, and deals the event accordingly depending
> > > on the setup.  The power-down behavior itself should be equivalent
> > > with "systemctl poweroff" or such.
> > The behaviour occurs even when booting into runlevel 3 /
> > multi-user.target so if no X11 or graphical DE is involved
> 
> In that case, systemd (logind) handles the event.

Hmm, do we confuse "poweroff" with "reboot" for some reason?
