From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 9/10] sh: Use struct syscore_ops instead of
	sysdev	class and sysdev
Date: Wed, 23 Mar 2011 11:12:20 +0000
Message-ID: <20110323111220.GB27671__28151.6006020412$1300878810$gmane$org@sirena.org.uk>
References: <201103100131.58206.rjw@sisk.pl> <201103222130.46603.rjw@sisk.pl>
	<1300826390.1815.5.camel@zag> <201103222200.52131.rjw@sisk.pl>
	<1300828356.1815.15.camel@zag> <20110322214922.GA7503@linux-sh.org>
	<1300831256.1815.22.camel@zag> <20110322222347.GA3978@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110322222347.GA3978@linux-sh.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 23, 2011 at 07:23:48AM +0900, Paul Mundt wrote:
> On Tue, Mar 22, 2011 at 11:00:56PM +0100, Kay Sievers wrote:

> > Which is what we need to get rid of. It does not make any sense on the
> > global picture to have anything like that exported to userspace.

> So far I haven't heard any rationale for why it doesn't. Exporting CPU
> state to userspace certainly makes sense, and the sysdev model has worked
> reasonably for CPUs, memory nodes, etc.

FWIW it'd be really helpful to have CPUs (or at least SoCs) be regular
struct devices for integration with the regulator API so we can have all
things that might use a regulator (like DVFS) be struct devices but...

> Once cpufreq, timekeeping, and NUMA node state have migrated to whatever
> the driver model folks find acceptable, I'll happily follow suit.

...we're not precisely there yet :/
