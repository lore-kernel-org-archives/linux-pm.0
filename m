From: Michal Hocko <mhocko@suse.cz>
Subject: [RFC 0/4] OOM vs PM freezer fixes
Date: Wed, 12 Nov 2014 19:58:48 +0100
Message-ID: <1415818732-27712-1-git-send-email-mhocko@suse.cz>
References: <20141110163055.GC18373@dhcp22.suse.cz>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20141110163055.GC18373@dhcp22.suse.cz>
Sender: owner-linux-mm@kvack.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org, linux-pm@vger.kernel.org, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,
here is another take at OOM vs. PM freezer interaction fixes/cleanups.
First three patches are fixes for an unlikely cases when OOM races with
the PM freezer which should be closed completely finally. The last patch
is a simple code enhancement which is not needed strictly speaking but
it is nice to have IMO.

Both OOM killer and PM freezer are quite subtle so I hope I haven't
missing anything. Any feedback is highly appreciated. I am also
interested about feedback for the used approach. To be honest I am not
really happy about spreading TIF_MEMDIE checks into freezer (patch 1)
but I didn't find any other way for detecting OOM killed tasks.

Changes are based on top of Linus tree (3.18-rc3).

Michal Hocko (4):
      OOM, PM: Do not miss OOM killed frozen tasks
      OOM, PM: make OOM detection in the freezer path raceless
      OOM, PM: handle pm freezer as an OOM victim correctly
      OOM: thaw the OOM victim if it is frozen

Diffstat says:
 drivers/tty/sysrq.c    |  6 ++--
 include/linux/oom.h    | 39 ++++++++++++++++------
 kernel/freezer.c       | 15 +++++++--
 kernel/power/process.c | 60 +++++++++-------------------------
 mm/memcontrol.c        |  4 ++-
 mm/oom_kill.c          | 89 ++++++++++++++++++++++++++++++++++++++------------
 mm/page_alloc.c        | 32 +++++++++---------
 7 files changed, 147 insertions(+), 98 deletions(-)

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
