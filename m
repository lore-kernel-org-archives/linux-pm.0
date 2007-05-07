From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] swsusp: Reduce code duplication between
	user.c and disk.c
Date: Mon, 7 May 2007 22:57:12 +0200
Message-ID: <200705072257.13405.rjw__36908.6461294957$1178571340$gmane$org@sisk.pl>
References: <200705052227.14265.rjw@sisk.pl>
	<1178538191.7261.13.camel@johannes.berg>
	<20070507122619.GE20605@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070507122619.GE20605@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Johannes Berg <johannes@sipsolutions.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>, Pekka Enberg <penberg@cs.helsinki.fi>
List-Id: linux-pm@vger.kernel.org

On Monday, 7 May 2007 14:26, Pavel Machek wrote:
> On Mon 2007-05-07 13:43:11, Johannes Berg wrote:
> > Hi,
> > 
> > > However, this modifies the user-observable behavior in such a way that
> > > if the user sets 'shutdown mode = platform' in the s2disk's configuration file,
> > > the kernel will use the hibernation mode resulting from the sysfs interface
> > > settings.  That is, if there is 'shutdown mode = platform' in the s2disk's
> > > configuration file, but the hibernation mode is set to 'reboot' in the sysfs
> > > interface, the system will be rebooted instead of going for the 'ACPI S0->S4
> > > transition'.
> > 
> > This I don't understand. Without looking at the code, it seems that
> > you're invoking some common code that checks the sysfs file. Couldn't
> > those functions take an argument instead?
> 
> I'll second this. Can we pass down an argument, meaning userland
> interface does not change?

Yes, we can.  I'll have an updated patch in a couple of days.

Greetings,
Rafael
