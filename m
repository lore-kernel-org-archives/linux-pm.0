From: Len Brown <lenb@kernel.org>
Subject: [GIT] idle patch for 2.6.39-merge
Date: Wed, 23 Mar 2011 23:12:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103232306511.3848__17888.6767746464$1300936531$gmane$org@x980>
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

This will update the file shown below.

thanks!

Len Brown
Intel Open Source Technology Center

ps. individual patches are available on linux-pm@lists.linux-foundation.org

 drivers/idle/intel_idle.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

through these commits:

Thomas Renninger (1):
      intel_idle: Rename cpuidle states

with this log:

commit 15e123e5d7e8ee9ba3717e743d8eb5fd0fe57712
Author: Thomas Renninger <trenn@suse.de>
Date:   Sun Feb 27 22:36:43 2011 +0100

    intel_idle: Rename cpuidle states
    
    Userspace apps might have to cut off parts off the
    idle state name for display reasons.
    Switch NHM-C1 to C1-NHM (and others) so that a cut off
    name is unique and makes sense to the user.
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    CC: lenb@kernel.org
    Signed-off-by: Len Brown <len.brown@intel.com>
