From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sat, 5 Dec 2009 18:05:14 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912051758190.3560__41322.032994549$1260065171$gmane$org@localhost.localdomain>
References: <200912052216.19540.rjw@sisk.pl> <200912060055.36130.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051635330.3560@localhost.localdomain>
	<200912060254.10081.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912060254.10081.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 6 Dec 2009, Rafael J. Wysocki wrote:
> 
> While the current settings are probably unsafe (like enabling PCI devices
> to be suspended asynchronously by default if there are not any direct
> dependences between them), there are provisions to make eveything safe, if
> we have enough information (which also is needed to put the required logic into
> the drivers).

I disagree.

Think of a situation that we already handle pretty poorly: USB mass 
storage devices over a suspend/resume.

> The device tree represents a good deal of the dependences
> between devices and the other dependences may be represented as PM links
> enforcing specific ordering of the PM callbacks.

The device tree means nothing at all, because it may need to be entirely 
rebuilt at resume time. 

Optimally, what we _should_ be doing (and aren't) for suspend/resume of 
USB is to just tear down the whole topology and rebuild it and re-connect 
the things like mass storage devices. IOW, there would be no device tree 
to describe the topology, because we're finding it anew. And it's one of 
the things we _would_ want to do asynchronously with other things.

We don't want to build up some irrelevant PM links and callbacks. We don't 
want to have some completely made-up new infrastructure for something that 
we _already_ want to handle totally differently for init time.

IOW, I argue very strongly against making up something PM-specific, when 
there really doesn't seem to be much of an advantage. We're much better 
off trying to share the init code than making up something new.

> I'd say if there's a worry that the same register may be accessed concurrently
> from two different code paths, there should be some locking in place.

Yeah. And I wish ACPI didn't exist at all. We don't know.

And we want to _limit_ our exposure to these things.

			Linus
