From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.19-rc5: known regressions
Date: Wed, 8 Nov 2006 09:52:35 +0100
Message-ID: <20061108085235.GT4729@stusta.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Len Brown <len.brown@intel.com>, gregkh@suse.de, Thierry Vignaud <tvignaud@mandriva.com>, discuss@x86-64.org, Ernst Herzberg <earny@net4u.de>, Aaron Durbin <adurbin@google.com>, Olivier Mondoloni <olivier.mondoloni@waika9.com>, Alex Romosan <romosan@sycorax.lbl.gov>, ak@suse.de, linux-ide@vger.kernel.org, oprofile-list@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Bryan O'Sullivan <bos@serpentine.com>, linux-pm@osdl.org, Komuro <komurojun-mbn@nifty.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Paolo Ornati <ornati@fastwebnet.it>, phil.el@wanadoo.fr, Matthew Wilcox <matthew@wil.cx>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, jgarzik@pobox.com
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 07, 2006 at 06:33:44PM -0800, Linus Torvalds wrote:
>...
> The rest is really mostly one-liners (or close) to various subsystems. Ne=
w =

> PCI ID's, trivial fixes, cifs, dvb, things like that. I'm feeling better =

> about this - there may be a -rc6, but maybe we don't even need one.
>...

Famous last words...  ;-)


This email lists some known regressions in 2.6.19-rc5 compared to 2.6.18.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : ThinkPad R50p: boot fail with (lapic && on_battery)
References : http://lkml.org/lkml/2006/10/31/333
Submitter  : Ernst Herzberg <earny@net4u.de>
Handled-By : Len Brown <len.brown@intel.com>
Status     : problem is being debugged


Subject    : ThinkPad T60: no screen after resume
References : http://mail.matrix.de/pipermail/linux-thinkpad/2006-November/0=
37011.html
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
Status     : unknown


Subject    : ThinkPad T60: lose ACPI events after suspend/resume
References : http://lkml.org/lkml/2006/10/10/39
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
Status     : problem might be fixed by
             commit f9dadfa71bc594df09044da61d1c72701121d802


Subject    : i386: more DWARFs and strange messages
References : http://lkml.org/lkml/2006/10/29/127
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
Status     : should be fixed by
             commit 4b96b1a10cb00c867103b21f0f2a6c91b705db11


Subject    : BUG: scheduling while atomic: events/0/0x00000001/4, etc..
References : http://lkml.org/lkml/2006/11/2/209
Submitter  : Paolo Ornati <ornati@fastwebnet.it>
Status     : unknown


Subject    : weird battery charge level reported
             ACPI Error method parse / execution failed
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D7466
Submitter  : Olivier Mondoloni <olivier.mondoloni@waika9.com>
Status     : unknown


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D7255
Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
Status     : unknown


Subject    : unable to rip cd
References : http://lkml.org/lkml/2006/10/13/100
Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
Status     : unknown


Subject    : x86_64: oprofile doesn't work
References : http://lkml.org/lkml/2006/10/27/3
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : unknown


Subject    : x86_64: NR_IRQ increase causes 11.5% slowdown
                     in lmbench's fork benchmark
References : http://lkml.org/lkml/2006/11/2/192
Submitter  : Tim Chen <tim.c.chen@linux.intel.com>
Caused-By  : Eric W. Biederman <ebiederm@xmission.com>
             commit 550f2299ac8ffaba943cf211380d3a8d3fa75301
Status     : unknown


Subject    : PCI: MMCONFIG breakage
References : http://lkml.org/lkml/2006/10/27/251
Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
Caused-By  : Andi Kleen <ak@suse.de>
             commit de09bddb9d6f96785be470c832b881e6d72d589f
Handled-By : Andi Kleen <ak@suse.de>
             Aaron Durbin <adurbin@google.com>
             Matthew Wilcox <matthew@wil.cx>
Status     : people are investigating


Subject    : SMP kernel can not generate ISA irq properly
References : http://lkml.org/lkml/2006/10/22/15
Submitter  : Komuro <komurojun-mbn@nifty.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : Thomas is investigating


Subject    : ipath driver MCEs system on load when HT chip present
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D7455
Submitter  : Bryan O'Sullivan <bos@serpentine.com>
Caused-By  : Eric W. Biederman <ebiederm@xmission.com>
Handled-By : Bryan O'Sullivan <bos@serpentine.com>
             Eric W. Biederman <ebiederm@xmission.com>
Status     : Bryan and Eric are working on fixing the ipath driver


Subject    : boot hang in the microcode driver
References : http://lkml.org/lkml/2006/11/6/117
Submitter  : Arjan van de Ven <arjan@linux.intel.com>
Caused-By  : Shaohua Li <shaohua.li@intel.com>
             commit a30a6a2cb0fdc2c9701d6ddfb21affeb8146c038
Handled-By : Arjan van de Ven <arjan@linux.intel.com>
Patch      : http://lkml.org/lkml/2006/11/6/117
Status     : workaround-patch available
