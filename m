From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [REGRESSION] usb devices don't wake up the system
Date: Sun, 4 Jul 2010 08:51:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007040848250.16841-100000@netrider.rowland.org>
References: <1278196923.14606.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1278196923.14606.4.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 4 Jul 2010, Maxim Levitsky wrote:

> > Alan. thanks for saving me from another bisect...
> > latest git tip works again.
> 
> I mean, I think that
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=48826626263d4a61d06fd8c5805da31f925aefa0
> 
> fixed the problem.

Ah, yes.  Well, I can't claim a lot of credit for that because I'm the 
person who introduced the regression in the first place!  But at least 
it's working okay now.

> > (of course I need to explicitly enable power/wakeup on the mouse), but I
> > can live with that.)
> > 
> > 
> > I want to note that I still need to enable wakeup in /power/acpi/wakeup
> > to make USB mouse wakeup the system.
> > This isn't a regression, but I thought that I don't need that anymore.

You shouldn't.  Which setting in /proc/acpi/wakeup needs to be enabled?

Alan Stern
