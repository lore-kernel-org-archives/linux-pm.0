From: shaohua.li@intel.com
Subject: [RFC 0/5] device wakeup event support
Date: Mon, 08 Sep 2008 17:19:26 +0800
Message-ID: <20080908091926.785882370__29290.3267116801$1220866562$gmane$org@sli10-desk.sh.intel.com>
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
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: dbrownell@users.sourceforge.net
List-Id: linux-pm@vger.kernel.org

This series add device wakeup event detection support. This is the base to
implement runtime device suspend/resume, though we don't support it now.
But David said USB is approaching to this. See this bugzilla
http://bugzilla.kernel.org/show_bug.cgi?id=6892 for detail.

The current process to handle wakeup event is:
1. driver enable wakeup event line pme and suspend
2. NPME or ACPI receives wakeup event
3. NPME or ACPI call .wakeup_event() to clear and disable wakeup event. Driver can do extra things in .wakeup_event() too.
4. NPME or ACPI call generic wakeup event handler (device_receive_wakeup_event())
5. device resumes, and goto 1 for next round of suspend

There are somethings we need discuss:
1. is this generic for other platforms?
2. what should the generic wakeup event handler do?

Comments and suggestions are welcome!

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
-- 
