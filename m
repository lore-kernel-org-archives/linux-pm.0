From: Adrian Bunk <bunk@stusta.de>
Subject: Linux 2.6.19-rc4: known unfixed regressions (v2)
Date: Fri, 3 Nov 2006 03:41:32 +0100
Message-ID: <20061103024132.GG13381@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, len.brown@intel.com, Thierry Vignaud <tvignaud@mandriva.com>, davej@codemonkey.org.uk, Ernst Herzberg <earny@net4u.de>, cpufreq@lists.linux.org.uk, Alex Romosan <romosan@sycorax.lbl.gov>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, oprofile-list@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>, linux-usb-devel@lists.sourceforge.net, discuss@x86-64.org, linux-pm@osdl.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Komuro <komurojun-mbn@nifty.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Tim Chen <tim.c.chen@linux.intel.com>, phil.el@wanadoo.fr, gregkh@suse.de, ak@suse.de, linux-acpi@vger.kernel.org, mingo@redhat.com, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-pm@vger.kernel.org

This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : i386: more DWARFs and strange messages
References : http://lkml.org/lkml/2006/10/29/127
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
Status     : unknown


Subject    : PCI: MMCONFIG breakage
References : http://lkml.org/lkml/2006/10/27/251
Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
Status     : unknown, both BIOS and Direct work


Subject    : x86_64: oprofile doesn't work
References : http://lkml.org/lkml/2006/10/27/3
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : unknown


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D7255
Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
Status     : unknown


Subject    : unable to rip cd
References : http://lkml.org/lkml/2006/10/13/100
Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
Status     : unknown


Subject    : cpufreq not working on AMD K8
References : http://lkml.org/lkml/2006/10/10/114
Submitter  : Christian <christiand59@web.de>
Status     : unknown


Subject    : SMP kernel can not generate ISA irq properly
References : http://lkml.org/lkml/2006/10/22/15
Submitter  : Komuro <komurojun-mbn@nifty.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : Thomas will investigate


Subject    : ThinkPad R50p: boot fail with (lapic && on_battery)
References : http://lkml.org/lkml/2006/10/31/333
Submitter  : Ernst Herzberg <earny@net4u.de>
Status     : problem is being debugged


Subject    : ThinkPad T43p/T60/X60s: lose ACPI events after suspend/resume
References : http://lkml.org/lkml/2006/10/10/39
             http://lkml.org/lkml/2006/10/4/425
             http://lkml.org/lkml/2006/10/16/262
             http://bugzilla.kernel.org/show_bug.cgi?id=3D7408
             http://lkml.org/lkml/2006/10/30/251
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
             "Michael S. Tsirkin" <mst@mellanox.co.il>
             Hugh Dickins <hugh@veritas.com>
Status     : problem is being debugged


Subject    : x86_64: NR_IRQ increase causes slowdown in lmbench's fork
References : http://lkml.org/lkml/2006/11/2/192
Submitter  : Tim Chen <tim.c.chen@linux.intel.com>
Caused-By  : Eric W. Biederman <ebiederm@xmission.com>
             commit 550f2299ac8ffaba943cf211380d3a8d3fa75301
Status     : problem is being debugged


Subject    : USB net drivers: missing MII select's
References : http://lkml.org/lkml/2006/10/25/209
Submitter  : Randy Dunlap <randy.dunlap@oracle.com>
Caused-By  : Arnd Bergmann <arnd@arndb.de>
             commit c41286fd42f3545513f8de9f61028120b6d38e89
Handled-By : Randy Dunlap <randy.dunlap@oracle.com>
             David Brownell <david-b@pacbell.net>
Status     : patches are being discussed
