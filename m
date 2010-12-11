From: Len Brown <lenb@kernel.org>
Subject: [git pull] idle patch for Linux-2.6.37-rc5
Date: Sat, 11 Dec 2010 02:22:00 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012110220230.27156__29741.6792520837$1292052232$gmane$org@x980>
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

bugfix for oversight that penalized EX systems.

This will update the file shown below.

thanks!
Len Brown
Intel Open Source Technology Center


ps. individual patches are available on linux-pm@lists.linux-foundation.org
and a consolidated plain patch is available here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/idle/patches/2.6.37/idle-release-2.6.37-rc4.diff.gz

 drivers/idle/intel_idle.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

through these commits:

Len Brown (1):
      intel_idle: recognize ARAT on WSM-EX

with this log:

commit 56b9aea3b740be7665be100872a913da9bdc653b
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 2 01:19:32 2010 -0500

    intel_idle: recognize ARAT on WSM-EX
    
    We erroneously ignored the Always Running APIC Timer on WSM-EX.
    Move the check for ARAT down so that it can apply to any/all models.
    
    Signed-off-by: Len Brown <len.brown@intel.com>
