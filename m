From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 0/5] b43: Fix suspend/resume deadlock
Date: Fri, 25 Jan 2008 01:27:20 +0100
Message-ID: <200801250127.21966.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Buesch <mb@bu3sch.de>, LKML <linux-kernel@vger.kernel.org>, Alessandro Rubini <rubini@vision.unipv.it>, pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches is intended to fix the suspend/resume deadlock
occuring as a result of unregistering device objects, locked by the PM core,
during suspend/resume cycles by the b43 driver.

In short, the b43 driver is modified to avoid unregistering device objects
during suspend/resume cycles except for the resume code path, in which the
devices are unregistered using the recently introduced suspend-safe method.
For this purpose, it is necessary to introduce the possibility to safely remove
misc devices, leds classdevs and hwrng devices during suspend/resume cycles
(patches 2/5, 4/5, 3/5, respectively).

Please consider for applying.

Thanks,
Rafael
