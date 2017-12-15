From: Laura Abbott <labbott@redhat.com>
Subject: [PATCH] cpupower: Remove FSF address
Date: Thu, 14 Dec 2017 17:16:29 -0800
Message-ID: <20171215011629.15655-1-labbott@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Laura Abbott <labbott@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Checkpatch in the kernel now complains about having the FSF address
in comments. Other tools such as rpmlint are now starting to do the
same thing. Remove the FSF address to reduce warnings on multiple tools.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
For context, I'm updating the packaging for the cpupower tools in Fedora which
requires a code/output review. This got flagged during that review.
---
 tools/power/cpupower/lib/cpufreq.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index 3b005c39f068..60beaf5ed2ea 100644
--- a/tools/power/cpupower/lib/cpufreq.h
+++ b/tools/power/cpupower/lib/cpufreq.h
@@ -11,10 +11,6 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #ifndef __CPUPOWER_CPUFREQ_H__
-- 
2.14.3
