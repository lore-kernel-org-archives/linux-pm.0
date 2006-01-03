From: <rasmit.ranjan@wipro.com>
Subject: RE: swsusp1 not working
Date: Tue, 3 Jan 2006 12:09:00 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB2012F560C@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============025377979222730662=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rjw@sisk.pl
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============025377979222730662==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

 Hi,
	As you have suggested I will try with kernel 2.6.14.5.This time
I tried something differenet.Now I changed my swap partition.Now my swap
partition is on LVM.So I reinstalled Linux-2.6.9 from cd. Then I
downloaded linux-2.6.13.3 and recompiled it.
I followed one document "acpi-how-to" and did the following steps to
suspend my system.

1. I did not use kernel parameter "resume= " in grub.config as it is
given that the 1st swap space will be used for image storage.

2.Then I create my initrd using the following command
	mkinitrd --allow-missing -f /boot/initrd-2.6.13.3.img 2.6.13.3

3.Then I did the following
	echo shutdown > /sys/power/disk
	echo disk > /sys/power/state

It seems my system is suspended. So when I press the power button it did
not resume but restarted.In boot log message I found something like this
		swapon:/dev/VolGroup00/LogVol01: invalid argument
		rc.sysinit: enabling swap space failed

Now it seems my swap partition has been crashed.
So after rebooting I tried following command
		swapon -s  //showed nothing
		cat /proc/swaps //showed nothing
		free  //this showed that the size of swap space is 0

So I tried to activate my swap space and typed this command
		swapon -a

But this gave the following error
		Unable to find swap-space signature
		swapon:/dev/VolGroup00/LogVol01: invalid argument

Now I can not do any thing until my swap space becomes activated.
First I did not get why my swap space got crashed ??
Second is there any way to activate my swap space ??

Please suggest.

Thanks and regards,
Rasmit.	


-----Original Message-----
From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
Sent: Monday, January 02, 2006 4:08 PM
To: Rasmit Ranjan (WT01 - Semiconductors & Consumer Electronics)
Subject: Re: [linux-pm] swsusp1 not working

Hi,

On Monday, 2 January 2006 05:33, you wrote:
> 
> Hi Rafael,
> 	I tried with resume=/dev/hdb2.
> In this case while booting its giving
> 
> 	swsusp:Suspend partition has wrong signature?

This only means swsusp tried to read a suspend image from the partition,
but it didn't found one (ie. normal).

> And after suspending using
> 
> 	echo shutdown > /sys/power/disk
> 	echo disk > /sys/power/state
> 
> It gives kernel panic.

Well, you're not giving a lot of information ...

Anyway, it's likely you're hitting a bug that has been fixed already.
Please try the 2.6.14.5 kernel and see if that works.

Greetings,
Rafael


--===============025377979222730662==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============025377979222730662==--
