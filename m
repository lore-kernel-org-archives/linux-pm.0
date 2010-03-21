From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Resume problem with radeon+KMS (2.6.34-rc2 and before)
Date: Sun, 21 Mar 2010 22:28:13 +0100
Message-ID: <201003212228.13923.rjw__17101.4689993628$1269206855$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: dri-devel@lists.sourceforge.net
Cc: =?iso-8859-2?q?J=E9r=F4me_Glisse?= <glisse@freedesktop.org>, pm list <linux-pm@lists.linux-foundation.org>, Dave Airlie <airlied@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Some time ago I reported a problem with resuming from suspend to RAM on
HP nx6325 with radeon+KMS.

The problem was that the first resume always failed if the suspend was started
from under X.  Moreover, the resume went correctly until the last switch from
the framebuffer console (which was now controlled by the radeon driver as
well) to X that made the box hang hard.

However, if the first resume was started from the (radeon-controlled)
framebuffer console, the subsequent resume succeeded and all of the next
attempts to suspend/resume succeeded, _regardless_ of the way the suspend was
started.

At that time Dave thought it might be a problem with the nx6325's graphics
adapter that apparently was a crappy one, but today I found that _exactly_ the
same behavior was observable on Acer Ferrari One, which was quite different,
hardware-wise, from the old HP box.  For this reason I think the problem is
related to the driver itself rather than to the hardware or firmware.

The problem is reproducible on both machines with the latest git kernel
and the user space radeon_drv.so from openSUSE 11.2 (it says
module version = 6.12.4 in the X log).  The kernel and user space are 64-bit
on both machines.  [For completness, the Acer box suspends and resumes
correctly with radeon.modeset=0 and "s2ram -f -p -m".]

Should I try a newer user space X driver?  Or may the problem be related to
the 64-bitness somehow?

Rafael
