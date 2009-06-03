From: Matt Helsley <matthltc@us.ibm.com>
Subject: [PATCH 0/4] cgroup freezer: Fixes and CHECKPOINTING
	support
Date: Wed,  3 Jun 2009 02:31:17 -0700
Message-ID: <cover.1244019829.git.matthltc__22538.7440216311$1244022150$gmane$org@us.ibm.com>
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
Cc: Cedric Le Goater <legoater@free.fr>, Oren Laadan <orenl@cs.columbia.edu>, Containers <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, Pavel Machek <pavel@suse.cz>, Paul Menage <menage@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


This series fixes a bug with the mainline cgroup freezer code and
cleans up the cgroup freezer before introducing the new
CHECKPOINTING state in the last patch. All but this last patch are
independent of checkpoint/restart and hence should be suitable for
mainline.

The bug was noticed by Oren Ladaan and allows tasks frozen via the
cgroup freezer to be thawed during resume when they should remain
frozen. In Oren's checkpoint/restart tree is means that
sys_checkpoint() sometimes returns EBUSY even when the cgroup is, 
in fact, fully frozen. (Workaround: cat /cgroup/foo/freezer.state
before doing checkpoint..)

The final patch, which adds the CHECKPOINTING state, incorporates
Oren's comments and should fix the lockdep bug he posted too. I 
haven't tested this latest version yet myself and I have a few things to 
attend to before I can get to it so I'm posting this for initial review
now. I believe this resolves all the pending comments I've seen about
the CHECKPOINTING state.

Cheers,
	-Matt Helsley

Matt Helsley (4):
  cgroup freezer: Fix buggy resume test for tasks frozen with cgroup
    freezer
  cgroup freezer: Avoid lazy state changes when convenient
  cgroup freezer: Update stale locking comments
  cgroup freezer: Add CHECKPOINTING state to safeguard container
    checkpoint

 Documentation/cgroups/freezer-subsystem.txt |   10 ++
 checkpoint/checkpoint.c                     |    8 +-
 include/linux/freezer.h                     |   15 ++-
 kernel/cgroup_freezer.c                     |  163 +++++++++++++++++++--------
 kernel/power/process.c                      |    2 +-
 5 files changed, 146 insertions(+), 52 deletions(-)
