From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 0/4] PM: Rework struct pm_ops and
	related things
Date: Sun, 24 Jun 2007 22:39:04 +0200
Message-ID: <200706242239.05678.rjw__28781.3920331702$1182720625$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi,

I had some time to create patches implementing my suggestions from the previous
thread "PM: Introduce set_target method in pm_ops".  For completness I also
include the first patch that introduces .set_target() into the series.

The following series of patches:
* introduces the .set_target() method in 'struct pm_ops' so that the platform
  code knows in advance what sleep state the system is going to enter (this
  is necessary for ACPI and at91)
* moves the definition of 'struct pm_ops' to <include/suspend.h>
* changes the name of 'struct pm_ops' to 'struct platform_suspend_operations'
  and modified the names of some related functions and global variables
  accordingly
* modifies 'struct platform_suspend_operations' so that .prepare() and
  .finish() don't take arguments (.enter() still takes the state argument, 
  because some platforms don't implement the other callbacks)

I was only able to compile the patches on a PC, so if you can point me to
any tools I can use for testing them on the other affected architectures,
I'd be grateful.

Comments welcome.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
