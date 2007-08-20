From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 0/4] Hibernation: Arbitrary boot kernel
	support on x86_64
Date: Mon, 20 Aug 2007 15:10:03 +0200
Message-ID: <200708201510.03734.rjw@sisk.pl>
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
Cc: discuss@x86-64.org, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

Hi,

After the kexec hibernation discussion I started to think what it would take to
change the restore code so that a hibernation image could be loaded and
restored with the help of a kernel different from the image one.  As a result,
I have created the following series of patches.

Except for that being an interesting problem, my motivation to do it is
two-fold.  First, it will allow us to eliminate the (annoying) requirement to
use the same kernel for hibernation and restore.  Second, it will allow us to
carry out the restore in a more or less ACPI-compliant way, by using an
ACPI-less kernel as the boot one.

As you can see in the patches, it doesn't take a lot of code to do that,
although conceptually it is a bit compilcated.  The first patch is the
essential one, as it contains all of the necessary bits.  The second one
makes the ACPI restore code work if ACPI has not been enabled during boot
before loading the image.  The last two patches are auxiliary, although they
improve the flexibility of the restore code.

Comments welcome.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
