From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] PCI PM fixes for 2.6.29
Date: Sat, 27 Dec 2008 16:27:32 +0100
Message-ID: <200812271627.32781.rjw__13094.8872691535$1230391999$gmane$org@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[Sorry, the previous attempt was HTML-formatted.]

Hi Jesse,

The following two patches contain fixes of PCI suspend-resume routines.

The first one corrects the suspend-resume handling for PCI Express ports after
commit 2bdc985ac3fcdb4ae9672feeb14de2c525967899 (in your tree).

The second one is a fix for devices without PM capability.

Sorry for being late with them, but I had to make sure that the first patch
doesn't break the test box affected by bug #12121 again.

Thanks,
Rafael
