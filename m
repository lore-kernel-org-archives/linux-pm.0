From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Wed, 25 Feb 2009 08:19:24 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902250818200.3111@localhost.localdomain>
References: <Pine.LNX.4.44L0.0902251027270.3373-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902251027270.3373-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Wed, 25 Feb 2009, Alan Stern wrote:

> On Tue, 24 Feb 2009, Rafael J. Wysocki wrote:
> 
> > I think the most important source of level triggered interrupts are PCI
> > devices, so perhaps we can make the PCI PM core use bit 10 of the PCI Device
> > Control register to prevent devices from generating INTx after the drivers'
> > suspend routines have been executed?
> 
> I wish that were true.  As I recall, the original PCI specification did
> not define this bit, and older PCI devices don't support it.  So you
> can't count on being able to supress interrupt generation this way.  

It's definitely a new feature. In fact, I think even the current one makes 
it optional, so even for "new" devices it's very unclear how many of them 
actually support that bit.

			Linus
