From: David Kilroy <kilroyd@googlemail.com>
Subject: [RFC PATCH 0/2] orinoco: Don't keep cached firmware
	around permanently
Date: Fri, 31 Oct 2008 01:15:41 +0000
Message-ID: <1225415743-28209-1-git-send-email-kilroyd__4321.38353721729$1225464264$gmane$org@googlemail.com>
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
To: linux-wireless@vger.kernel.org, orinoco-devel@lists.sourceforge.net
Cc: David Kilroy <kilroyd@googlemail.com>, linux-pm@lists.linux-foundation.org, arvidjaar@mail.ru
List-Id: linux-pm@vger.kernel.org

The recent patch to load orinoco firmware correctly on resume simply
kept the firmware in RAM for the entire time the module was loaded, and
only applied to Agere firmware.

The first patch uses the new power management notifiers to load and
release the firmware prior to suspend and after resume (for both Agere
and Symbol). I'm not an expert on where suspend/resume is headed, so I'd
appreciate any advice from linux-pm on whether this is the preferred way
to do things.

The second patch makes the spectrum_cs driver actually invoke this
functionality during resume.

David Kilroy (2):
  orinoco: Use PM notifier to cache firmware for use during resume
  orinoco: Resume spectrum_cs in the same way as orinoco_cs

 drivers/net/wireless/orinoco.c     |  140 ++++++++++++++++++++++++++++--------
 drivers/net/wireless/orinoco.h     |    8 ++-
 drivers/net/wireless/spectrum_cs.c |   21 +++++-
 3 files changed, 135 insertions(+), 34 deletions(-)
