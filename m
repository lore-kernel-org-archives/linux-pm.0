From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: "1 lock held by file-storage" while in idle thread
Date: Thu, 10 Oct 2013 18:40:43 +0200
Message-ID: <20131010164043.GA20301@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mandeep Singh Baines <msb-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Since commit 0f9548ca1 ("lockdep: check that no locks held at freeze
time") I see the following backtrace in the file storage gadget [0]:
|=====================================
|[ BUG: file-storage/662 still has locks held! ]
|3.12.0-rc4+ #2 Not tainted
|-------------------------------------
|1 lock held by file-storage/662:
| #0:  (&common->file_lock){+.+...}, at: [<f84cf3af>] fsg_main_thread+0x34f/0x14b0 [g_multi]
|
|Call Trace:
| [<c14ef9c9>] dump_stack+0x4b/0x79
| [<c10a2ca1>] debug_check_no_locks_held+0x91/0xa0
| [<f84ce1b9>] sleep_thread.isra.29+0x79/0xc0 [g_multi]
| [<f84ceb53>] do_write+0x213/0x440 [g_multi]
| [<f84cf715>] fsg_main_thread+0x6b5/0x14b0 [g_multi]

The lock acquired in do_scsi_command() and do_write() calls sleep_thread()
until date is written (I guess).
Any recommendations on getting rid of this? Should sleep_thread() skip
calling try_to_freeze() if the lock is held and "just" scheduling away?

[0] drivers/usb/gadget/f_mass_storage.c

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
