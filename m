From: Adrian Bunk <bunk@stusta.de>
Subject: [4/6] 2.6.21-rc3: known regressions
Date: Tue, 13 Mar 2007 13:50:11 +0100
Message-ID: <20070313125011.GU18731@stusta.de>
References: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Ray Lee <ray-lk@madrabbit.org>, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, linux-pci@atrey.karlin.mff.cuni.cz, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

This email lists some known regressions in Linus' tree compared to 2.6.20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : ThinkPad X60: resume no longer works  (PCI related?)
References : http://lkml.org/lkml/2007/3/13/3
Submitter  : Dave Jones <davej@redhat.com>
Caused-By  : PCI merge
             commit 78149df6d565c36675463352d0bfe0000b02b7a7
Handled-By : Eric W. Biederman <ebiederm@xmission.com>
             Rafael J. Wysocki <rjw@sisk.pl>
Status     : problem is being debugged


Subject    : ThinkPad doesn't resume from suspend to RAM
References : http://lkml.org/lkml/2007/2/27/80
             http://lkml.org/lkml/2007/2/28/348
Submitter  : Jens Axboe <jens.axboe@oracle.com>
             Jeff Chua <jeff.chua.linux@gmail.com>
Status     : unknown


Subject    : suspend to disk hangs
References : http://lkml.org/lkml/2007/3/6/142
Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
Status     : unknown


Subject    : laptop immediately resumes after suspend
References : http://lkml.org/lkml/2007/3/8/469
Submitter  : Ray Lee <ray-lk@madrabbit.org>
Caused-By  : Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
             commit ed41dab90eb40ac4911e60406bc653661f0e4ce1
Handled-By : Len Brown <lenb@kernel.org>
Patch      : http://lkml.org/lkml/2007/3/12/228
Status     : patch available
