From: Len Brown <lenb@kernel.org>
Subject: Re: [Resend][PATCH] ACPI / EC: Remove race between EC
 driver and suspend process (rev. 3)
Date: Thu, 04 Mar 2010 00:55:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1003040047310.1741__2084.54566677592$1267682313$gmane$org@localhost.localdomain>
References: <201002272140.36891.rjw@sisk.pl>
	<alpine.LFD.2.00.1003031644410.1044@localhost.localdomain>
	<201003040152.58437.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201003040152.58437.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Isn't the problem at hand that the boot-kernel stops
in mid-transaction, and the resumed hibernate image
then blunders forward with its first transaction
only to find the EC in an intermediate state?

If yes, I then making the transaction atomic WRT
the boot kernel stopping should fix the problem.

The patch sets a FROZEN bit, and subsequent
requests for EC transactions simply fail.
How do we know that we set the bit at the right time?
What transactions or parts of transactions will fail,
and what are the consequences of those failures?

thanks,
Len Brown, Intel Open Source Technology Center
