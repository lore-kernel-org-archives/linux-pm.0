From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: apm_emulation regression
Date: Fri, 14 Dec 2007 07:31:32 +1100
Message-ID: <1197577892.15741.143.camel@pasglop>
References: <1197427530.8385.59.camel@pasglop>
	<1197482587.6558.145.camel@johannes.berg>
	<1197546020.6558.247.camel@johannes.berg>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1197546020.6558.247.camel@johannes.berg>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-pm <linux-pm@lists.osdl.org>, ralf <ralf@linux-mips.org>
List-Id: linux-pm@vger.kernel.org


On Thu, 2007-12-13 at 12:40 +0100, Johannes Berg wrote:
> > > That basically means X will break. That's why X broke on the latest
> > > ubuntu until I whacked some new scripts in them to force console
> > > switching, among other things. Possibly other apps that relied
> > > on /dev/apm_bios to be notified of system suspend/resume broke as well.
> > 
> > Ah. I guess I never noticed because I had the scripts to do console
> > switching all along.
> 
> Actually, it just occurred to me that the *kernel* does a console switch
> when we use /sys/power/state, so maybe that is why I never had a problem
> rather than userspace doing a console switch (which it only started
> doing very recently)

The kernel console switching can be disabled and -is- by some distros.
For example, the problem I was having was when testing Gutsy before it
was final, the script to console switch wasn't in the right place for
powermac and didn't work. X wouldn't be suspended properly and the
machine would lockup.

In general, we should try to fix that, as other things might rely
on /dev/apm_bios doing the right thing.

Ben.
