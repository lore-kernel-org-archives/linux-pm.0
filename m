From: Len Brown <lenb@kernel.org>
Subject: [GIT] tools/power patches for 2.6.38-rc4
Date: Tue, 15 Feb 2011 15:53:41 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1102151549560.843__15955.5399361581$1297874010$gmane$org@x980>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-idle-2.6.git tools-release

a bug-fix, plus some style updates that didn't seem worth delaying,
especially since turbostat is brand-new to the tree in 2.6.38.

This will update the files shown below.

thanks!

Len Brown
Intel Open Source Technology Center


ps. individual patches are available on linux-pm@lists.linux-foundation.org

 tools/power/x86/turbostat/turbostat.c |  200 ++++++++++++++++-----------------
 1 files changed, 98 insertions(+), 102 deletions(-)

through these commits:

Len Brown (1):
      tools: turbostat: style updates

Thomas Renninger (1):
      tools: turbostat: fix bitwise and operand

with this log:

commit a829eb4d7e08b316e2d48880ecab3630497f300f
Author: Len Brown <len.brown@intel.com>
Date:   Thu Feb 10 23:36:34 2011 -0500

    tools: turbostat: style updates
    
    Follow kernel coding style traditions more closely.
    Delete typedef, re-name "per cpu counters" to
    simply be counters etc.
    
    This patch changes no functionality.
    
    Suggested-by: Thiago Farina <tfransosi@gmail.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8209e054b6bd0805a25b8c4af971160fa146bf22
Author: Thomas Renninger <trenn@suse.de>
Date:   Fri Jan 21 15:11:19 2011 +0100

    tools: turbostat: fix bitwise and operand
    
    bug could cause false positive on indicating
    presence of invarient TSC or APERF support.
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>
