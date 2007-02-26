From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Mon, 26 Feb 2007 23:01:52 +0100
Message-ID: <20070226220152.GA29575@stusta.de>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>, linux-pm@lists.osdl.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>, lenb@kernel.org, linux-acpi@vger.kernel.org, luming.yu@intel.com, Arkadiusz Miskiewicz <arekm@maven.pl>, Konstantin Karasyov <konstantin.a.karasyov@intel.com>, linux-usb-devel@lists.sourceforge.net, Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>, Fabio Comolli <fabio.comolli@gmail.com>, Thomas Meyer <thomas.mey@web.de>, Andrew Nelless <andrew@nelless.net>, "Antonino A. Daplas" <adaplas@gmail.com>, Janosch Machowinski <jmachowinski@gmx.de>, vladimir.p.lebedev@intel.com, Lukas Hejtmanek <xhejtman@fi.muni.cz>, Meelis Roos <mroos@linux.ee>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Jean-Luc Coulon <jean.luc.co>
List-Id: linux-pm@vger.kernel.org

This email lists some known regressions in 2.6.21-rc1 compared to 2.6.2=
0
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possib=
ly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering=
=2E


Subject    : resume: slab error in verify_redzone_free(): cache `size-5=
12':
                     memory outside object was overwritten
References : http://lkml.org/lkml/2007/2/24/41
Submitter  : Pavel Machek <pavel@ucw.cz>
Handled-By : Marcel Holtmann <marcel@holtmann.org>
Status     : unknown


Subject    : ThinkPad T60: no screen after suspend to RAM
References : http://lkml.org/lkml/2007/2/22/391
Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
Handled-By : Ingo Molnar <mingo@elte.hu>
Status     : unknown


Subject    : HP nx6325 notebook: usb mouse stops working after suspend =
to ram
References : http://lkml.org/lkml/2007/2/21/413
Submitter  : Arkadiusz Miskiewicz <arekm@maven.pl>
Caused-By  : Konstantin Karasyov <konstantin.a.karasyov@intel.com>
             commit 0a6139027f3986162233adc17285151e78b39cac
Status     : unknown


Subject    : ACPI update breaks kpowersave
References : http://lkml.org/lkml/2007/2/10/7
Submitter  : Ismail D=C3=B6nmez <ismail@pardus.org.tr>
             Fabio Comolli <fabio.comolli@gmail.com>
Status     : unknown


Subject    : MacBook: AE_NOT_FOUND ACPI messages
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8066
Submitter  : Thomas Meyer <thomas.mey@web.de>
Status     : unknown


Subject    : Asus A8N-VM motherboard:
             framebuffer/console boot failure boot failure (ACPI relate=
d)
References : http://lkml.org/lkml/2007/2/23/132
Submitter  : Andrew Nelless <andrew@nelless.net>
Handled-By : Antonino A. Daplas <adaplas@gmail.com>
Status     : problem is being debugged


Subject    : Asus M6Ne notebook: ACPI: First battery is not detected
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8080
Submitter  : Janosch Machowinski <jmachowinski@gmx.de>
Status     : unknown


Subject    : Asus M6Ne/M6A notebooks: SATA_ACPI errors during kernel bo=
ot
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8080
             http://bugzilla.kernel.org/show_bug.cgi?id=3D8046
Submitter  : Janosch Machowinski <jmachowinski@gmx.de>
             Lukas Hejtmanek <xhejtman@fi.muni.cz>
Status     : unknown


Subject    : ata-piix ACPI errors (40/80 pin cable mix)
References : http://lkml.org/lkml/2007/2/22/159
Submitter  : Meelis Roos <mroos@linux.ee>
Status     : unknown


Subject    : libata: PATA UDMA/100 configured as UDMA/33
References : http://lkml.org/lkml/2007/2/20/294
             http://www.mail-archive.com/linux-ide@vger.kernel.org/msg0=
4115.html
Submitter  : Fabio Comolli <fabio.comolli@gmail.com>
Handled-By : Tejun Heo <htejun@gmail.com>
Status     : problem is being discussed


Subject    : sata_via failure
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8025
Submitter  : Jean-Luc Coulon <jean.luc.coulon@gmail.com>
             Markus Trippelsdorf <markus@trippelsdorf.de>
Handled-By : Tejun Heo <htejun@gmail.com>
Patch      : http://www.mail-archive.com/linux-ide@vger.kernel.org/msg0=
3945.html
Status     : patch available


Subject    : BUG: at drivers/pci/pci.c:817 pcim_enable_device() (libata=
)
References : http://lkml.org/lkml/2007/2/14/275
             http://lkml.org/lkml/2007/2/22/367
Submitter  : Rafael J. Wysocki <rjw@sisk.pl>
             Lukas Hejtmanek <xhejtman@mail.muni.cz>
Handled-By : Tejun Heo <htejun@gmail.com>
Patch      : http://lkml.org/lkml/2007/2/25/102
Status     : patch available


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
