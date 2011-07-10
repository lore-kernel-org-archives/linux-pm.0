From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] PM / Domains: Add code for powering off all
	unused PM domains
Date: Sun, 10 Jul 2011 22:46:04 +0200
Message-ID: <201107102246.05107.rjw__26322.3447640941$1310331224$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches are on top of the branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-domains

and the patchset I sent earlier today:

https://lkml.org/lkml/2011/7/10/27

and this patch: https://patchwork.kernel.org/patch/961202/

They introduce a mechanism allowing platforms to power off all of the PM
domains that don't contain devices in use in one shot.  The first patch
adds core support for that and the second one makes shmobile use it
instead of its own code.

Thanks,
Rafael
