From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/7] Fix the ACPI 1.0 vs ACPI 2.0 suspend
	ordering issue
Date: Thu, 27 Dec 2007 19:03:52 +0100
Message-ID: <200712271903.53961.rjw__20382.5086392046$1198778628$gmane$org@sisk.pl>
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
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, "Moore,
	Robert" <robert.moore@intel.com>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following patchset is intended to fix the ACPI 1.0 vs ACPI 2.0 suspend
ordering issue described at http://bugzilla.kernel.org/show_bug.cgi?id=9528 and
in a recent LKML thread (http://lkml.org/lkml/2007/12/25/37).

The patches actually do more than that, as I think it's reasonable to untangle
some ACPI-specific suspend code by the way.  The details are described in the
changelogs.

The patches apply on top of the suspend branch of the ACPI tree
(git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6 suspend),
but they are also included in the quilt patch series at:
http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.24-rc6/patches/ .

Please review (and test, if possible).

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
