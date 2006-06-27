From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-pm] windfarm got signal
Date: Tue, 27 Jun 2006 17:44:28 +1000
Message-ID: <1151394268.2350.61.camel@localhost.localdomain>
References: <1150847482.16662.13.camel@johannes>
	<1150956123.3633.23.camel@localhost.localdomain>
	<200606221303.19860.rjw@sisk.pl> <1150974836.16258.29.camel@johannes>
	<1150976092.16258.33.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1150976092.16258.33.camel@johannes>
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
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2006-06-22 at 13:34 +0200, Johannes Berg wrote:
> On Thu, 2006-06-22 at 13:13 +0200, Johannes Berg wrote:
> 
> > Thanks, I'll look and submit a patch. It does try_to_freeze() but also
> > checks for pending signals.
> 
> Ah. The code is just in the wrong order:

The code should be

while (!kthread_should_stop()) {
  try_to_freeze();
  ...
  schedule_timeout_interruptible(...);
}

That is, I think we just don't care about the signal stuff.

Care to do a new patch ?

Cheers,
Ben.
