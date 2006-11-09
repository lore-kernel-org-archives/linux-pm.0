From: Martin Lorenz <martin@lorenz.eu.org>
Subject: Re: 2.6.19-rc5: known regressions
Date: Thu, 9 Nov 2006 09:04:58 +0100
Message-ID: <20061109080458.GB6073@gimli>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061108085235.GT4729@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>, gregkh@suse.de, Thierry Vignaud <tvignaud@mandriva.com>, discuss@x86-64.org, Ernst Herzberg <earny@net4u.de>, Aaron Durbin <adurbin@google.com>, Olivier Mondoloni <olivier.mondoloni@waika9.com>, Alex Romosan <romosan@sycorax.lbl.gov>, ak@suse.de, linux-ide@vger.kernel.org, oprofile-list@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Bryan O'Sullivan <bos@serpentine.com>, Linus Torvalds <torvalds@osdl.org>, linux-pm@osdl.org, Komuro <komurojun-mbn@nifty.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Paolo Ornati <ornati@fastwebnet.it>, phil.el@wanadoo.fr, Matthew Wilcox <matthew@wil.cx>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, mingo@redhat.com
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 08, 2006 at 09:52:35AM +0100, Adrian Bunk wrote:
> On Tue, Nov 07, 2006 at 06:33:44PM -0800, Linus Torvalds wrote:
> >...
> > The rest is really mostly one-liners (or close) to various subsystems. =
New =

> > PCI ID's, trivial fixes, cifs, dvb, things like that. I'm feeling bette=
r =

> > about this - there may be a -rc6, but maybe we don't even need one.
> >...
> =

> Famous last words...  ;-)
> =

> =

> This email lists some known regressions in 2.6.19-rc5 compared to 2.6.18.
[...]

compiled the latest git yesterday evening =


current kernel is 2.6.19-rc5+ieee80211+e1000-45.3+1909-g6a4abeae-dirty

Commit: 6a4abeaefae897ded6b39ed3f3a84662923e6b60
Author: Martin Lorenz <mlo@gimli.(none)> Wed, 08 Nov 2006 19:58:44 +0100

which is my e1000 patch =


Commit: 17dfbe2264b50308189de1fe4068bdffbf065dfc
Author: Martin Lorenz <mlo@gimli.(none)> Wed, 08 Nov 2006 19:58:44 +0100

which is the patch to upgrade ieee80211 to V.1.2.15 so I can use ipw3945


Commit: 48797ebd9e8b16fddcd4ef062f792314a6b9219a
Author: Linus Torvalds <torvalds@merom.osdl.org> Wed, 08 Nov 2006 10:27:54
-0800

...the version I pulled

$ cg-status
Heads:
    >master     6a4abeaefae897ded6b39ed3f3a84662923e6b60
     origin     082f2f84be5db164280483efa7eb1549d867353d


it's an X60s BTW
> =

> Subject    : ThinkPad T60: no screen after resume
> References : http://mail.matrix.de/pipermail/linux-thinkpad/2006-November=
/037011.html
> Submitter  : Martin Lorenz <martin@lorenz.eu.org>
> Status     : unknown
> =

> =

seems fixed
I have to retest it, but it came back nicely on two subsequent
suspend/resume cycles

> Subject    : ThinkPad T60: lose ACPI events after suspend/resume
> References : http://lkml.org/lkml/2006/10/10/39
> Submitter  : Martin Lorenz <martin@lorenz.eu.org>
> Status     : problem might be fixed by
>              commit f9dadfa71bc594df09044da61d1c72701121d802
> =


same as above

> =

> Subject    : i386: more DWARFs and strange messages
> References : http://lkml.org/lkml/2006/10/29/127
> Submitter  : Martin Lorenz <martin@lorenz.eu.org>
> Status     : should be fixed by
>              commit 4b96b1a10cb00c867103b21f0f2a6c91b705db11

none present in my current dmesg

I will keep testing and reporting :-)

thanks a lot =

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
