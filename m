From: Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: [RFC][PATCH 2/3] PM: Make console suspending configureable
Date: Mon, 04 Sep 2006 23:27:42 +0200
Message-ID: <44FC9A4E.9070604@free.fr>
References: <200608151509.06087.rjw@sisk.pl> <200608161309.34370.rjw@sisk.pl> <20060904090820.GA4500@suse.de> <200609041303.25817.rjw@sisk.pl> <20060904110229.GM9991@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964988AbWIDV2I@vger.kernel.org>
In-Reply-To: <20060904110229.GM9991@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Stefan Seyfried <seife@suse.de>, Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Le 04.09.2006 13:02, Pavel Machek a =E9crit :
> On Mon 2006-09-04 13:03:25, Rafael J. Wysocki wrote:
>> On Monday, 4 September 2006 11:08, Stefan Seyfried wrote:
>>> Hi,
>>>
>>> sorry, i am only slowly catching up after vacation.
>>>
>>> On Wed, Aug 16, 2006 at 01:09:34PM +0200, Rafael J. Wysocki wrote:
>>>> Change suspend_console() so that it waits for all consoles to flus=
h the
>>>> remaining messages and make it possible to switch the console susp=
ending
>>>> off with the help of a Kconfig option.
>>>>
>>>> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>>>> +#ifndef CONFIG_DISABLE_CONSOLE_SUSPEND
>>>>  /**
>>>>   * suspend_console - suspend the console subsystem
>>>>   *
>>>> @@ -709,8 +710,14 @@ int __init add_preferred_console(char *n
>>>>   */
>>>>  void suspend_console(void)
>>>>  {
>>>> +	printk("Suspending console(s)\n");
>>>>  	acquire_console_sem();
>>>>  	console_suspended =3D 1;
>>>> +	/* This is needed so that all of the messages that have already =
been
>>>> +	 * written to all consoles can be actually transmitted (eg. over=
 a
>>>> +	 * network) before we try to suspend the consoles' devices.
>>>> +	 */
>>>> +	ssleep(2);
>>> Sorry, but no. Suspend and resume is already slow enough, no need t=
o make
>>> both of them much slower.
>>> If we can condition this on the netconsole being used, ok, but not =
for the
>>> most common case of "console is on plain VGA".
>> Hm, it already is in -mm, but of course I can prepare a patch that r=
emoves
>> this ssleep().
>>
>> Pavel, what do you think?
>=20
> Well, in suspend-to-ram case, 2 seconds is quite a lot... like more
> than rest of suspend, so stefan has some point...

Rafael added this "ssleep 2" because of a bug I reported on LKML,=20
see the thread "2.6.18-rc4-mm1: eth0: trigger_send() called with=20
the transmitter busy"
(http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115565636718377&w=3D=
2).

Basically, I was having issues when suspending with netconsole
on my Realtek RTL-8029 network card (ne2k-pci).

But further investigations revealed that this driver (ne2k-pci)
have issues with suspend/resume even when netconsole is disabled
(see http://bugzilla.kernel.org/show_bug.cgi?id=3D7082). These days,
I'm unable to do some tests with latest kernels because my ADSL
router is broken.

The point of this mail is that we should get rid of this "ssleep
2" since nobody else reported such an issue with netconsole and
the network driver I'm using appears to be not so clean.

~~
laurent
