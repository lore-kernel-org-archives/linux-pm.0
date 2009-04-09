From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] Add late pm notifiers for hibernate
Date: Thu, 9 Apr 2009 14:17:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0904091414340.2992-100000__40701.1122828864$1239301310$gmane$org@iolanthe.rowland.org>
References: <1239205077.4241.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1239205077.4241.15.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: schwidefsky@de.ibm.com, linux-pm@lists.linux-foundation.org, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 8 Apr 2009, Michael Holzheu wrote:

> From: Michael Holzheu <holzheu at linux.vnet.ibm.com>
> 
> This patch is a suggestion to solve the issue reported by Ursula Braun:
> https://lists.linux-foundation.org/pipermail/linux-pm/2009-March/020443.html
> 
> On s390 we have device drivers that don't belong to a Linux bus. Therefore
> we can't use the PM device callbacks (dev_pm_ops). The only way to get
> informed that we hibernate or resume is the pm_notifier_call_chain.

I'm curious to know what device drivers these are that don't have a 
bus.  Could they use the platform bus?  That's more or less what it's 
intended for -- devices that don't fit anywhere else.

> Unfortunately some of our drivers need a frozen userspace to do their
> hibernate actions and the current notifiers are called before userspace is
> frozen. Another point is that we want our console driver to suspend as late
> as possible so that we can see all the hibernate progress messages on the
> console.

It's possible to avoid suspending the console at all if you boot with
"no_console_suspend" as a kernel parameter.

Alan Stern
