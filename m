From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / sleep: Let devices force direct_complete
Date: Fri, 08 May 2015 13:33:36 -0700
Message-ID: <7hioc2hkrj.fsf@deeprootsystems.com>
References: <1430474611-25560-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430474611-25560-1-git-send-email-tomeu.vizoso@collabora.com>
	(Tomeu Vizoso's message of "Fri, 1 May 2015 12:03:30 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Tomeu Vizoso <tomeu.vizoso@collabora.com> writes:

> Introduce a new per-device flag power.force_direct_complete that will
> instruct the PM core to let that device remain in runtime suspend when
> the system goes into a sleep power state, regardless of the PM state of
> any of its descendants.
>
> This is needed because otherwise it would be needed to get dozens of
> drivers to implement the prepare() callback and be runtime PM active
> even if they don't have a 1-to-1 relationship with a piece of HW.
>
> This only applies to devices that aren't wakeup-capable, as those would
> need to setup their IRQs as wakeup-capable in their prepare() callbacks.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>
> Hi,
>
> I'm sending this as a standalone patch as suggested by Alan.
>
> Thanks,
>
> Tomeu
>
> ---
>  Documentation/power/runtime_pm.txt | 10 ++++++++++
>  drivers/base/power/main.c          | 14 ++++++++++----
>  include/linux/pm.h                 |  1 +
>  3 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index 44fe1d2..3b0c68d 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -665,6 +665,16 @@ as appropriate.  This only applies to system suspend transitions that are not
>  related to hibernation (see Documentation/power/devices.txt for more
>  information).
>  
> +For devices that know that can remain runtime suspended when the system

s/that know that/that know they/ ?

> +transitions to a sleep state regardless of the PM state of their descendants,
> +the flag power.force_direct_complete can be set on their device structures.
> +This can be useful when a real device has several virtual devices as
> +descendants and it would be very cumbersome to make sure that they return a
> +positive value in their .prepare() callback and have runtime PM enabled. Usage
> +of power.force_direct_complete is only allowed to devices that aren't
> +wakeup-capable, as they would need to set their IRQs as wakeups in their
> +.prepare() callbacks before the system transitions to a sleep state.

Kevin
