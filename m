From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] Suspend and hibernation test facility
	(rev. 2)
Date: Sat, 3 Nov 2007 20:54:39 +0100
Message-ID: <200711032054.40195.rjw__5464.62557181275$1194119037$gmane$org@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This is the second iteration of the patches that add a new testing facility for
suspend and hibernation.

The first patch adds the possibility to test the suspend (STD) core code
without actually suspending, which is useful for tracking problems with drivers
etc.

The second one modifies the hibernation core so that it can use the same
facility (it's a bit more powerful than the existing hibernation test modes,
since they really can't test the ACPI global methods).

The third one modified documentation in accordance with the two previous ones.

Comments welcome.

Greetings,
Rafael
