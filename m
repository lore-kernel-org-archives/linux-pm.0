From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5] Async suspend/resume tree
Date: Sun, 13 Dec 2009 23:38:30 +0100
Message-ID: <200912132338.30921.rjw__12181.7547166303$1260744826$gmane$org@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

After the async suspend/resume patches in my original pull request had been
rejected, I created an async suspend tree to save store some async-related
patches in there so that they don't get lost.  Today I rebased it on top of the
latest async suspend/resume patch posted here:
http://lkml.org/lkml/2009/12/12/124

It is on top of my linux-next tree containing the patches that I'm planning to
include in the next pull request.

At the moment, the following patches are in the async tree at:
http://git.kernel.org/?p=linux/kernel/git/rafael/suspend-2.6.git;a=shortlog;h=refs/heads/async

Please let me know if there are objections to any of them.

Thanks,
Rafael
