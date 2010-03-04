From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH] ACPI / EC: Remove race between EC
	driver and suspend process (rev. 3)
Date: Thu, 4 Mar 2010 20:20:54 +0100
Message-ID: <201003042020.54715.rjw__8546.58921384743$1267730431$gmane$org@sisk.pl>
References: <201002272140.36891.rjw@sisk.pl>
	<alpine.LFD.2.00.1003040047310.1741@localhost.localdomain>
	<9b2b86521003040132v168399ct9241f3ad9ff8c4c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9b2b86521003040132v168399ct9241f3ad9ff8c4c7@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thursday 04 March 2010, Alan Jenkins wrote:
> On 3/4/10, Len Brown <lenb@kernel.org> wrote:
> > Isn't the problem at hand that the boot-kernel stops
> > in mid-transaction, and the resumed hibernate image
> > then blunders forward with its first transaction
> > only to find the EC in an intermediate state?
> >
> > If yes, I then making the transaction atomic WRT
> > the boot kernel stopping should fix the problem.
> >
> > The patch sets a FROZEN bit, and subsequent
> > requests for EC transactions simply fail.
> > How do we know that we set the bit at the right time?

Well, setting it later simply doesn't make sense and setting it earlier might
disturb things.

> > What transactions or parts of transactions will fail,
> > and what are the consequences of those failures?
> 
> The problem transactions on my machine were probably started by
> ec_check_sci().  I.e. QUERY transactions which read the value of an
> event raised by the EC.  (I triggered the problem by pressing ACPI
> hotkeys, although I haven't been able to reproduce it since).
> 
> That might explain why the transactions can be asynchronous with the
> s2disk task - because these transactions are run in the ACPI
> workqueue.  Perhaps the workqueue needs to be flushed after the EC GPE
> is disabled?

Yes, and that's what the patch does.  It calls acpi_os_wait_events_complete()
to flush the workqueue (actually, two of them) and _then_ sets the FROZEN
bit.

Dropping stuff on the floor after the FROZEN bit has been set doesn't change
things too much, because we're going to turn interrupts off shortly after that.
However, the FROZEN bit is set under the EC mutex, which automatically makes
us wait if any transaction is in progress while we're trying to set the FROZEN
bit.

Rafael
