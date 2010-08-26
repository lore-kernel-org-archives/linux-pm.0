From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM QoS fixes for 2.6.36
Date: Thu, 26 Aug 2010 22:06:53 +0200
Message-ID: <201008262206.53748.rjw__29397.7635949433$1282853520$gmane$org@sisk.pl>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Saravana Kannan <skannan@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <linux@treblig.org>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull two PM QoS fixes for 2.6.36 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

They fix a kzalloc() call with swapped arguments and a kerneldoc comment
that doesn't match the code it describes any more after the last PM QoS
update.


 kernel/pm_qos_params.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

---------------

David Alan Gilbert (1):
      PM QoS: Fix kzalloc() parameters swapped in pm_qos_power_open()

Saravana Kannan (1):
      PM QoS: Fix inline documentation.
