From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] Suspend and hibernation test facility (rev.
	2)
Date: Fri, 9 Nov 2007 00:31:44 +0100
Message-ID: <200711090031.45852.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series of patches adds a new testing facility for suspend and hibernation.

The first patch adds the possibility to test the suspend (STD) core code
without actually suspending, which is useful for tracking problems with drivers
etc.

The second one modifies the hibernation core so that it can use the same
facility (it's a bit more powerful than the existing hibernation test modes,
since they really can't test the ACPI global methods).

The third one modified documentation in accordance with the two previous ones.

Please add to the suspend branch.

Greetings,
Rafael
