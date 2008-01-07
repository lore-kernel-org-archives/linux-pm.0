From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/7] Fix the ACPI 1.0 vs ACPI 2.0 suspend
	ordering issue (rev. 3)
Date: Tue, 8 Jan 2008 00:02:23 +0100
Message-ID: <200801080002.25044.rjw__15997.4927119494$1199747631$gmane$org@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Len,

The following patchset is intended to fix the ACPI 1.0 vs ACPI 2.0 suspen=
d
ordering issue described at http://bugzilla.kernel.org/show_bug.cgi?id=3D=
9528 and
in a recent LKML thread (http://lkml.org/lkml/2007/12/25/37).

The patches actually do more than that, as I think it's reasonable to unt=
angle
some ACPI-specific suspend code when we're at it. =A0The details are desc=
ribed in
the changelogs.

The patches are intended for 2.6.25.

Please add them to the suspend branch.

Thanks,
Rafael
