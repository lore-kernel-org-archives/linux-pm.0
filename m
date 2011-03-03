From: Len Brown <lenb@kernel.org>
Subject: [GIT] idle patches for 2.6.38-rc7
Date: Wed, 02 Mar 2011 20:43:32 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1103022041370.12344__13932.1292670958$1299116776$gmane$org@x980>
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

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-idle-2.6.git idle-release

This will update the files shown below.

thanks!

Len Brown
Intel Open Source Technology Center

 arch/x86/include/asm/msr-index.h |    5 +++++
 drivers/idle/intel_idle.c        |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

through these commits:

Len Brown (2):
      intel_idle: disable NHM/WSM HW C-state auto-demotion
      intel_idle: disable Atom/Lincroft HW C-state auto-demotion

with this log:

commit bfb53ccf1c734b1907df7189eef4c08489827951
Author: Len Brown <len.brown@intel.com>
Date:   Wed Feb 16 01:32:48 2011 -0500

    intel_idle: disable Atom/Lincroft HW C-state auto-demotion
    
    Just as we had to disable auto-demotion for NHM/WSM,
    we need to do the same for Atom (Lincroft version).
    
    In particular, auto-demotion will prevent Lincroft
    from entering the S0i3 idle power saving state.
    
    https://bugzilla.kernel.org/show_bug.cgi?id=25252
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 14796fca2bd22acc73dd0887248d003b0f441d08
Author: Len Brown <len.brown@intel.com>
Date:   Tue Jan 18 20:48:27 2011 -0500

    intel_idle: disable NHM/WSM HW C-state auto-demotion
    
    Hardware C-state auto-demotion is a mechanism where the HW overrides
    the OS C-state request, instead demoting to a shallower state,
    which is less expensive, but saves less power.
    
    Modern Linux should generally get exactly the states it requests.
    In particular, when a CPU is taken off-line, it must not be demoted, else
    it can prevent the entire package from reaching deep C-states.
    
    https://bugzilla.kernel.org/show_bug.cgi?id=25252
    
    Signed-off-by: Len Brown <len.brown@intel.com>
