From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/2] PM: Update system power off code
Date: Sun, 1 Jul 2007 20:51:47 +0200
Message-ID: <200707012051.48338.rjw__12686.1835750335$1183315724$gmane$org@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches update the system power off code.  They:
* remove the (unnecessary) call to acpi_sleep_prepare(ACPI_STATE_S4) from
  acpi_shutdown()
* remove acpi_sysclass and device_acpi that are only defined to register the
  ACPI power off preparation callback in acpi_shutdown() and introduce more
  general mechanism instead
The details are in the changelogs.

Comments welcome.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
