From: Adrian Bunk <bunk@stusta.de>
Subject: [4/5] 2.6.21-rc5: known regressions
Date: Tue, 27 Mar 2007 03:59:49 +0200
Message-ID: <20070327015949.GB16477@stusta.de>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, pavel@suse.cz, linux-pm@lists.osdl.org, Thomas Meyer <thomas@m3y3r.de>, =?utf-8?B?RnLDqWTDqXJpYw==?= Riss <frederic.riss@gmail.com>, Marcus Better <marcus@better.se>, Tobias Doerffel <tobias.doerffel@gmail.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Soeren Sonnenburg <kernel@nn7.de>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Maxim Levitsky <maximlevitsky@gmail.com>, tigran@aivazian.fsnet.co.uk
List-Id: linux-pm@vger.kernel.org

This email lists some known regressions in Linus' tree compared to 2.6.=
20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering=
=2E


Subject    : ThinkPad X60: resume no longer works  (PCI related?)
References : http://lkml.org/lkml/2007/3/13/3
Submitter  : Dave Jones <davej@redhat.com>
             Jeremy Fitzhardinge <jeremy@goop.org>
Caused-By  : PCI merge
             commit 78149df6d565c36675463352d0bfe0000b02b7a7
Handled-By : Eric W. Biederman <ebiederm@xmission.com>
             Rafael J. Wysocki <rjw@sisk.pl>
Status     : problem is being debugged


Subject    : second suspend to disk in a row results in an oops  (MSI)
References : http://lkml.org/lkml/2007/3/17/43
             http://lkml.org/lkml/2007/3/22/150
             http://lkml.org/lkml/2007/3/26/205
             http://lkml.org/lkml/2007/3/26/76
Submitter  : Thomas Meyer <thomas@m3y3r.de>
             Fr=C3=A9d=C3=A9ric Riss <frederic.riss@gmail.com>
             Marcus Better <marcus@better.se>
Handled-By : Eric W. Biederman <ebiederm@xmission.com>
Patch      : http://lkml.org/lkml/2007/3/24/136
Status     : patch was suggested


Subject    : Suspend to RAM doesn't work anymore  (ACPI?)
References : http://lkml.org/lkml/2007/3/19/128
             http://bugzilla.kernel.org/show_bug.cgi?id=3D8247
Submitter  : Tobias Doerffel <tobias.doerffel@gmail.com>
Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
             Len Brown <len.brown@intel.com>
Status     : problem is being debugged


Subject    : s2ram autowake regression  (ACPI?)
References : http://lkml.org/lkml/2007/3/20/96
Submitter  : Pavel Machek <pavel@ucw.cz>
Handled-By : Len Brown <lenb@kernel.org>
Status     : submitter was asked to test a patch


Subject    : SATA breakage on resume
References : http://lkml.org/lkml/2007/3/7/233
Submitter  : Thomas Gleixner <tglx@linutronix.de>
             Soeren Sonnenburg <kernel@nn7.de>
Status     : unknown


Subject    : suspend to disk: keypress required for power down
References : http://lkml.org/lkml/2007/3/25/78
Submitter  : Thomas Meyer <thomas@m3y3r.de>
Status     : unknown


Subject    : resume from RAM corrupts vesafb console
References : http://lkml.org/lkml/2007/3/26/76
Submitter  : Marcus Better <marcus@better.se>
Handled-By : Pavel Machek <pavel@ucw.cz>
Status     : problem is being debugged


Subject    : suspend to disk: non-boot cpus are disabled again
References : http://lkml.org/lkml/2007/3/25/78
Submitter  : Thomas Meyer <thomas@m3y3r.de>
Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
             Eric W. Biederman <ebiederm@xmission.com>
Status     : problem is being debugged


Subject    : ThinkPad doesn't resume from suspend to RAM
References : http://lkml.org/lkml/2007/2/27/80
             http://lkml.org/lkml/2007/2/28/348
Submitter  : Jens Axboe <jens.axboe@oracle.com>
             Jeff Chua <jeff.chua.linux@gmail.com>
Status     : unknown


Subject    : suspend to disk hangs  (microcode driver)
References : http://lkml.org/lkml/2007/3/16/126
Submitter  : Maxim Levitsky <maximlevitsky@gmail.com>
Caused-By  : Rafael J. Wysocki <rjw@sisk.pl>
             commit e3c7db621bed4afb8e231cb005057f2feb5db557
             commit ed746e3b18f4df18afa3763155972c5835f284c5
             commit 259130526c267550bc365d3015917d90667732f1
Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
Patch      : http://lkml.org/lkml/2007/3/23/179
Status     : patch available



-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
