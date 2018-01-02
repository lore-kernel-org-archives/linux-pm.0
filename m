From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [GIT PULL] cpupower update for 4.16-rc1
Date: Tue, 2 Jan 2018 16:13:17 -0700
Message-ID: <47ae2127-281c-89ae-2818-faa17ed86047@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C372C0C5F471A3F3268EA89D"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:48158 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbeABXNV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Jan 2018 18:13:21 -0500
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>

This is a multi-part message in MIME format.
--------------C372C0C5F471A3F3268EA89D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

Please pull the cpupower update for 4.16-rc1.

This update consists of a patch to remove FSF address.
Diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------------------------------------
The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-4.16-rc1

for you to fetch changes up to 0e96a0c83f0842d5cfd83b0a896bc82ff61f9849:

  cpupower: Remove FSF address (2017-12-15 08:27:39 -0700)

----------------------------------------------------------------
linux-cpupower-4.16-rc1

This update consists of a patch to remove FSF address.

----------------------------------------------------------------
Laura Abbott (1):
      cpupower: Remove FSF address

 tools/power/cpupower/lib/cpufreq.h | 4 ----
 1 file changed, 4 deletions(-)

----------------------------------------------------------------------------------------------

--------------C372C0C5F471A3F3268EA89D
Content-Type: text/x-patch;
 name="linux-cpupower-4.16-rc1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="linux-cpupower-4.16-rc1.diff"

diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/li=
b/cpufreq.h
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
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
  */
=20
 #ifndef __CPUPOWER_CPUFREQ_H__

--------------C372C0C5F471A3F3268EA89D--
