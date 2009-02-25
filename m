From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Wed, 25 Feb 2009 10:32:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902251027270.3373-100000__11720.6746749163$1235576399$gmane$org@iolanthe.rowland.org>
References: <200902242342.07721.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902242342.07721.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, 24 Feb 2009, Rafael J. Wysocki wrote:

> I think the most important source of level triggered interrupts are PCI
> devices, so perhaps we can make the PCI PM core use bit 10 of the PCI Device
> Control register to prevent devices from generating INTx after the drivers'
> suspend routines have been executed?

I wish that were true.  As I recall, the original PCI specification did
not define this bit, and older PCI devices don't support it.  So you
can't count on being able to supress interrupt generation this way.  

Alan Stern
