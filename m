From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [2.6.30-rc1-git2 regressions] Hibernation broken and
	(minor but annoying) audio problem
Date: Fri, 10 Apr 2009 00:57:41 +0200
Message-ID: <200904100057.43827.rjw__38616.6919641711$1239318301$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

I'm seeing two problems with -git from today.

First, resume from hibernation is apparently broken if the storage driver
handling the resume device is modular.  If it is compiled statically into
the kernel, the resume works correctly.  I guess this is a consequence of the
async changes (Arjan, please help).

Second, KDE4 on openSUSE 11.1 sometimes fails to handle audio correctly after
a fresh boot.  Everything seems to work, but there's no sound at all.  It is
sufficient to close the X session and start the desktop environment again to
make it work, though (may that be async too? ;-)).  The hardware in question is
Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller
(rev 02) and the driver is snd_hda_intel.

Thanks,
Rafael
