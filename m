From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 00/12] powerpc/powermac power management patches
Date: Wed, 07 Feb 2007 13:45:36 +0100
Message-ID: <20070207124536.963531000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Here's my current patch series that grew from implementing suspend to disk
for my powermac to a general suspend code cleanup.

One of the nice patches in this series allows you to finally suspend
via
  echo mem > /sys/power/state
on powerbooks!

I've tested this whole patchset on my powerbook as well as my powermac
(which can with it suspend for the first time) and it all works well.

I expect that you will be finding problems with this, but I hope to
get this included some time in the not-too-distant future.

This patchset depends on the patches
 * snd-aoa: fix onyx resume
 * windfarm: don't die on suspend thread signal
to work, but will probably not apply unless you also have
 * powermac: clean up PIC initialisation code

johannes
