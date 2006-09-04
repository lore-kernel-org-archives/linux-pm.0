From: Stefan Seyfried <seife@suse.de>
Subject: Re: [RFC][PATCH 2/3] PM: Make console suspending configureable
Date: Mon, 4 Sep 2006 11:08:20 +0200
Message-ID: <20060904090820.GA4500@suse.de>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz> <200608161304.51758.rjw@sisk.pl> <200608161309.34370.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751097AbWIDJIn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200608161309.34370.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

sorry, i am only slowly catching up after vacation.

On Wed, Aug 16, 2006 at 01:09:34PM +0200, Rafael J. Wysocki wrote:
> Change suspend_console() so that it waits for all consoles to flush t=
he
> remaining messages and make it possible to switch the console suspend=
ing
> off with the help of a Kconfig option.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

> +#ifndef CONFIG_DISABLE_CONSOLE_SUSPEND
>  /**
>   * suspend_console - suspend the console subsystem
>   *
> @@ -709,8 +710,14 @@ int __init add_preferred_console(char *n
>   */
>  void suspend_console(void)
>  {
> +	printk("Suspending console(s)\n");
>  	acquire_console_sem();
>  	console_suspended =3D 1;
> +	/* This is needed so that all of the messages that have already bee=
n
> +	 * written to all consoles can be actually transmitted (eg. over a
> +	 * network) before we try to suspend the consoles' devices.
> +	 */
> +	ssleep(2);

Sorry, but no. Suspend and resume is already slow enough, no need to ma=
ke
both of them much slower.
If we can condition this on the netconsole being used, ok, but not for =
the
most common case of "console is on plain VGA".

--=20
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write.=
"
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Co=
hen

--=20
VGER BF report: U 0.49988
