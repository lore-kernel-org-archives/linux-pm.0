From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 0/3] pm_qos: redo as plist and remove allocations
Date: Mon, 28 Jun 2010 12:33:54 -0500
Message-ID: <1277746434.10879.191.camel@mulgrave.site>
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
To: Linux PM <linux-pm@lists.linux-foundation.org>
Cc: markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

I've done a bit more testing and sorted out some bugs (including several
in the plist patch where it wasn't firing the notifier correctly).

It looks OK to my test set up, but since I'm using artificial pm_qos
things, it would be good to have the real consumers test it out.

This is the patch layout:

James Bottomley (3):
  plist: add plist_last
  pm_qos: reimplement using plists
  pm_qos: get rid of the allocation in pm_qos_add_request()

 drivers/net/e1000e/netdev.c            |   17 +--
 drivers/net/igbvf/netdev.c             |    9 +-
 drivers/net/wireless/ipw2x00/ipw2100.c |   12 +-
 include/linux/netdevice.h              |    2 +-
 include/linux/plist.h                  |   29 +++++
 include/linux/pm_qos_params.h          |   13 ++-
 include/sound/pcm.h                    |    2 +-
 kernel/pm_qos_params.c                 |  211 +++++++++++++++++---------------
 sound/core/pcm_native.c                |   13 +--
 9 files changed, 175 insertions(+), 133 deletions(-)
