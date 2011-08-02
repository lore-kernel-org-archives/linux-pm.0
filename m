From: Len Brown <lenb@kernel.org>
Subject: [GIT PATCH] tools/power patches for Linux 3.1
Date: Tue, 02 Aug 2011 18:40:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1108021838520.25237__424.705053637986$1312324948$gmane$org@x980>
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

This will update the files shown below.

thanks!

Len Brown
Intel Open Source Technology Center

ps. individual patches are available on linux-pm@lists.linux-foundation.org

 tools/power/x86/turbostat/turbostat.c              |   46 ++++++++++----------
 .../x86_energy_perf_policy.c                       |    5 +-
 2 files changed, 25 insertions(+), 26 deletions(-)

through these commits:

Len Brown (2):
      tools/power x86_energy_perf_policy: fix print of uninitialized string
      tools/power turbostat: fit output into 80 columns on snb-ep

with this log:

commit d30c4b7a87e8b19583d5ef1402d9b38f51e30f44
Author: Len Brown <len.brown@intel.com>
Date:   Sun Jul 31 18:19:33 2011 -0400

    tools/power turbostat: fit output into 80 columns on snb-ep
    
    Reduce columns for package number to 1.
    If you can afford more than 9 packages,
    you can also afford a terminal with more than 80 columns:-)
    
    Also shave a column also off the package C-states
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e4c0d0e22ce5cf84b3993b5af6c2dac08d52f06b
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jul 15 23:39:00 2011 -0400

    tools/power x86_energy_perf_policy: fix print of uninitialized string
    
    Looks like I was going to stick the brand string
    in the verbose ouput, but didn't get around to it.
    
    Signed-off-by: Len Brown <len.brown@intel.com>
