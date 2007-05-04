From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 4 May 2007 23:06:26 +0200
Message-ID: <200705042306.27060.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705041020530.3417-100000@iolanthe.rowland.org>
	<200705042220.24518.rjw@sisk.pl>
	<1178310082.7408.33.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178310082.7408.33.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 22:21, Johannes Berg wrote:
> On Fri, 2007-05-04 at 22:20 +0200, Rafael J. Wysocki wrote:
> 
> > > On the other hand, steps 6 and 7 aren't really needed for hibernation.  
> > > You _could_ shut the system off completely (ACPI S5).  Automatic wakeup
> > > wouldn't work, but the next time the user turned the computer on manually
> > > it would still resume from hibernation.
> > 
> > That's correct, with the exception that the user may find the system not fully
> > functional after the resume in that case.
> 
> Why is that anyway? Is it just a matter of the acpi code getting
> confused about the acpi bios state?

Yes, I think so.

> How can the acpi bios possibly be screwed up after what it must see as a
> fresh boot? Does the acpi code poke it in ways it's not supposed to be poked
> after a fresh boot?

Sort of.

Greetings,
Rafael
