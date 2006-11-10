From: Martin Lorenz <martin@lorenz.eu.org>
Subject: Re: 2.6.19-rc5: known regressions
Date: Fri, 10 Nov 2006 08:53:52 +0100
Message-ID: <20061110075352.GA5962@gimli>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de> <20061109080458.GB6073@gimli>
	<20061109135530.GA6600@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061109135530.GA6600@gimli>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ernst Herzberg <earny@net4u.de>, Len Brown <len.brown@intel.com>, mingo@redhat.com, pavel@suse.cz, linux-pm@osdl.org, Paolo Ornati <ornati@fastwebnet.it>, Olivier Mondoloni <olivier.mondoloni@waika9.com>, linux-acpi@vger.kernel.org, Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Alex Romosan <romosan@sycorax.lbl.gov>, Jens Axboe <jens.axboe@oracle.com>, Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr, oprofile-list@lists.sourceforge.net, ak@suse.de, discuss@x86-64.org, Tim Chen <tim.c.chen@linux.intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Aaron Durbin <adurbin@google.com>, Matthew
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 09, 2006 at 02:55:30PM +0100, Dipl.-Ing. Martin Lorenz wrote:
> > =

> > current kernel is 2.6.19-rc5+ieee80211+e1000-45.3+1909-g6a4abeae-dirty
> > =

> > Commit: 6a4abeaefae897ded6b39ed3f3a84662923e6b60
> > Author: Martin Lorenz <mlo@gimli.(none)> Wed, 08 Nov 2006 19:58:44 +0100
> > =

> > which is my e1000 patch =

> > =

> > Commit: 17dfbe2264b50308189de1fe4068bdffbf065dfc
> > Author: Martin Lorenz <mlo@gimli.(none)> Wed, 08 Nov 2006 19:58:44 +0100
> > =

> > which is the patch to upgrade ieee80211 to V.1.2.15 so I can use ipw3945
> > =

> > =

> > Commit: 48797ebd9e8b16fddcd4ef062f792314a6b9219a
> > Author: Linus Torvalds <torvalds@merom.osdl.org> Wed, 08 Nov 2006 10:27=
:54
> > -0800
> > =

> > ...the version I pulled
> > =

> > $ cg-status
> > Heads:
> >     >master     6a4abeaefae897ded6b39ed3f3a84662923e6b60
> >      origin     082f2f84be5db164280483efa7eb1549d867353d
> > =

> > =

> > it's an X60s BTW
> > > =

> > > Subject    : ThinkPad T60: no screen after resume
> > > References : http://mail.matrix.de/pipermail/linux-thinkpad/2006-Nove=
mber/037011.html
> > > Submitter  : Martin Lorenz <martin@lorenz.eu.org>
> > > Status     : unknown
> > > =

> > > =

> > seems fixed
> > I have to retest it, but it came back nicely on two subsequent
> > suspend/resume cycles
> =

> did a lot of testing now.
> no more black screen after resume

wellllll

just had one.
I am not sure, what was different this time
I had my system up and running since yesterdays report and suspended it
several times.

now I got a black screen again and it seems, that the keyboard was
dysfunctional too this time - well kind of. I could not switch screens (how
should I have noticed success with a completely black screen) not even the
flickering I saw last time. but hittinf Ctrl-Alt-Del did a clean reboot


I found this in the Xorg log after reboot

(II) I810(0): BIOS call 0x5f05 not supported, setting refresh with VBE 3
method.(II) I810(0): xf86UnbindGARTMemory: unbind key 9
(II) I810(0): xf86UnbindGARTMemory: unbind key 0
(II) I810(0): xf86UnbindGARTMemory: unbind key 1
(II) I810(0): xf86UnbindGARTMemory: unbind key 3
(II) I810(0): xf86UnbindGARTMemory: unbind key 4
(II) I810(0): xf86UnbindGARTMemory: unbind key 2
(II) I810(0): xf86UnbindGARTMemory: unbind key 5
(II) I810(0): xf86UnbindGARTMemory: unbind key 6
(II) I810(0): xf86UnbindGARTMemory: unbind key 7
(II) I810(0): xf86UnbindGARTMemory: unbind key 8
(WW) I810(0): Successfully set original devices (2)
SetGrabKeysState - disabled
(WW) Open ACPI failed (/var/run/acpid.socket) (No such file or directory)
(II) No APM support in BIOS or kernel
(II) Screen 0 shares mem & io resources
(II) Screen 1 shares mem & io resources
(II) Screen 0 shares mem & io resources
(II) Screen 1 shares mem & io resources
(II) AIGLX: Resuming AIGLX clients after VT switch
(II) I810(0): Detected resume, re-POSTing.
(WW) I810(0): Bad V_BIOS checksum
(II) I810(0): Primary V_BIOS segment is: 0xc000


I will upload my latest logs to www.lorenz.eu.org/~mlo/kernel

I did a SysRq-t before uploading the messages log

one thing was different indeed: I was online my home wlan using
ipw3945-1.1.2

this driver was not loaded on any suspend before

but on other differences as far as I recall

> =

> > =

> > > Subject    : ThinkPad T60: lose ACPI events after suspend/resume
> > > References : http://lkml.org/lkml/2006/10/10/39
> > > Submitter  : Martin Lorenz <martin@lorenz.eu.org>
> > > Status     : problem might be fixed by
> > >              commit f9dadfa71bc594df09044da61d1c72701121d802
> > > =

> > =

> > same as above
> ACPI seems to be ok as well
> nothing strange happening anymore even after a LOT of fancy playing around
> =


in the situation described above I tried to suspend again using Fn-F4
without success

and nothing in the acpid logfile that shows this keypress


> > =

> > > =

> > > Subject    : i386: more DWARFs and strange messages
> > > References : http://lkml.org/lkml/2006/10/29/127
> > > Submitter  : Martin Lorenz <martin@lorenz.eu.org>
> > > Status     : should be fixed by
> > >              commit 4b96b1a10cb00c867103b21f0f2a6c91b705db11
> > =

> > none present in my current dmesg
> not one since I booted this kernel
> =

> > =

> > I will keep testing and reporting :-)
> > =

> > thanks a lot =

>   mlo
> --
> Dipl.-Ing. Martin Lorenz
> =

>             They that can give up essential liberty =

> 	    to obtain a little temporary safety =

> 	    deserve neither liberty nor safety.
>                                    Benjamin Franklin
> =

> please encrypt your mail to me
> GnuPG key-ID: F1AAD37D
> get it here:
> http://blackhole.pca.dfn.de:11371/pks/lookup?op=3Dget&search=3D0xF1AAD37D
> =

> ICQ UIN: 33588107

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty =

	    to obtain a little temporary safety =

	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=3Dget&search=3D0xF1AAD37D

ICQ UIN: 33588107
