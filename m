From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [BUG] Commit "Hibernation: Enter platform hibernation
	state in a consistent way)" makes my system to resume instantly
	from S4
Date: Sat, 27 Oct 2007 14:05:32 +0200
Message-ID: <200710271405.32908.maximlevitsky__44633.6602130488$1193486959$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Recently I noticed that my system resumes just after suspend to disk.

I traced this to commit 9cd9a0058dd35268b24fa16795a92c800f4086d4.

Note:

This happens only if I enable WOL using /proc/acpi/wakeup
(echo "ILAN" > /proc/acpi/wakeup)

and have 
"ACPI-Hibernate-erroneously-disabled-Suspend-wakeup" applied, since otherwise
all wake-up sources are disabled in S4.


Clearly the above commit confuses the BIOS.
Using latest -git with the above patch reverted makes everything work again fine.

Best regards,
	Maxim Levitsky
