From: Adrian Bunk <bunk@stusta.de>
Subject: [5/6] 2.6.21-rc3: known regressions
Date: Tue, 13 Mar 2007 13:50:16 +0100
Message-ID: <20070313125016.GV18731@stusta.de>
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
Cc: Soeren Sonnenburg <kernel@nn7.de>, Arkadiusz Miskiewicz <arekm@maven.pl>, linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-ide@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Tomas Janousek <tomi@nomi.cz>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com
List-Id: linux-pm@vger.kernel.org

This email lists some known regressions in Linus' tree compared to 2.6.20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : resume: slab error in verify_redzone_free(): cache `size-512':
                     memory outside object was overwritten
References : http://lkml.org/lkml/2007/2/24/41
Submitter  : Pavel Machek <pavel@ucw.cz>
Status     : unknown


Subject    : beeps get longer after suspend
References : http://lkml.org/lkml/2007/2/26/276
Submitter  : Pavel Machek <pavel@ucw.cz>
Status     : unknown


Subject    : suspend/resume hangs until keypress
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8181
Submitter  : Tomas Janousek <tomi@nomi.cz>
Status     : unknown


Subject    : SATA breakage on resume
References : http://lkml.org/lkml/2007/3/7/233
Submitter  : Thomas Gleixner <tglx@linutronix.de>
             Soeren Sonnenburg <kernel@nn7.de>
Status     : unknown


Subject    : first disk access after resume takes several minutes
References : http://lkml.org/lkml/2007/3/8/117
Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
Status     : unknown


Subject    : after resume: X hangs after drawing a couple of windows
References : http://lkml.org/lkml/2007/3/8/117
Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
Status     : unknown


Subject    : ThinkPad Z60m: usb mouse stops working after suspend to ram
References : http://lkml.org/lkml/2007/2/21/413
             http://lkml.org/lkml/2007/2/28/172
Submitter  : Arkadiusz Miskiewicz <arekm@maven.pl>
Caused-By  : Konstantin Karasyov <konstantin.a.karasyov@intel.com>
             commit 0a6139027f3986162233adc17285151e78b39cac
Handled-By : Konstantin Karasyov <konstantin.a.karasyov@intel.com>
Status     : problem is being debugged


Subject    : suspend to disk breaks ACPI
References : http://lkml.org/lkml/2007/3/5/127
Submitter  : Lukas Hejtmanek <xhejtman@mail.muni.cz>
Status     : unknown
