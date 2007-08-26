From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PM: Improve ACPI handling during
	suspend and hibernation (rev. 2)
Date: Mon, 27 Aug 2007 01:49:51 +0200
Message-ID: <200708270149.52585.rjw__33256.1066993096$1188171980$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi,

This is the second revision of the patches intended to improve the handli=
ng of
the ACPI platform during suspend and hibernation.

They do the following things:
* make hibernation_platform_enter() consistent with the sleep state enter=
ing
=A0 code in kernel/power/main.c
* introduce global platform callbacks allowing us to handle ACPI in a mor=
e fine
=A0 grained way during suspend and hibernation
* improve the handling of the system status indicator during suspend and
=A0 hibernation.
Details are in the changelogs.

Comments welcome.

Greetings,
Rafael
