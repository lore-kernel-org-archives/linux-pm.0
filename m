From: Kay Sievers <kay.sievers@suse.de>
Subject: Re: [PATCH 9/10] sh: Use struct syscore_ops instead of
 sysdev class and sysdev
Date: Wed, 23 Mar 2011 00:05:11 +0100
Message-ID: <1300835111.1815.69.camel__12534.2403458946$1300835367$gmane$org@zag>
References: <201103100131.58206.rjw@sisk.pl>
	<201103222200.52131.rjw@sisk.pl> <1300828356.1815.15.camel@zag>
	<201103222305.01808.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103222305.01808.rjw@sisk.pl>
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
Cc: Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2011-03-22 at 23:05 +0100, Rafael J. Wysocki wrote:
> On Tuesday, March 22, 2011, Kay Sievers wrote:

> >> Because they are devices, and there is a lot to win, if the kernel
> > exports all "devices" in the same way. This is not about saving an inode
> > in /sys, it's the ability to do runtime device configuration with common
> > tools.
> 
> If I understand you correctly, the goal is to have everything under
> /sys/devices/ been represented by struct device objects and there are good
> reasons to do that.
> 
> In that case we either have to move the things exported via sysdevs somewhere
> else (presumably having to create that "somewhere" before), or we have to
> introduce struct device objects specifically for exporting them.  I don't
> really think the latter approach will be very popular, so quite likely we'll
> need to have a plan for moving those things to different locations.

Ok, now that we sorted the misunderstanding out, let's start this topic
from here again. (I really read your reply as: "let's move the CPUS
somewhere else")


What's the list of stuff you discovered using sysdevs, which is not a
device at all, and has never more than a single instance of stuff of the
same type? The clocksource?

And let's find some place for them to put their properties instead of
messing around with device from the driver core.

Kay
