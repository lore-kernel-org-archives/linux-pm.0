From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 9/10] sh: Use struct syscore_ops instead of
	sysdev class and sysdev
Date: Wed, 23 Mar 2011 07:23:48 +0900
Message-ID: <20110322222347.GA3978__38383.8920774453$1300832874$gmane$org@linux-sh.org>
References: <201103100131.58206.rjw@sisk.pl> <201103222130.46603.rjw@sisk.pl>
	<1300826390.1815.5.camel@zag> <201103222200.52131.rjw@sisk.pl>
	<1300828356.1815.15.camel@zag> <20110322214922.GA7503@linux-sh.org>
	<1300831256.1815.22.camel@zag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1300831256.1815.22.camel@zag>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kay Sievers <kay.sievers@suse.de>
Cc: Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 22, 2011 at 11:00:56PM +0100, Kay Sievers wrote:
> On Wed, 2011-03-23 at 06:49 +0900, Paul Mundt wrote:
> > The comment at the top of sys.c says:
> > 
> >  * sys.c - pseudo-bus for system 'devices' (cpus, PICs, timers, etc)
> 
> Which is what we need to get rid of. It does not make any sense on the
> global picture to have anything like that exported to userspace.
> 
So far I haven't heard any rationale for why it doesn't. Exporting CPU
state to userspace certainly makes sense, and the sysdev model has worked
reasonably for CPUs, memory nodes, etc.

> People should really stop messing around in /sys for optimization
> purposes. We have a common device model, and need to use it. Sysdevs do
> not fit into that model.
> 
> I can't tell how that fits into your use case, but please use something
> else than sysfs, if you need device information exported, but you can't
> use "struct device".
> 
As long as CPU state is present in sysfs people will be tied to it for
per-CPU kobjects and the like, and until something concrete is proposed
for what to do about these cases there's not much chance of sysdevs going
away.

Once cpufreq, timekeeping, and NUMA node state have migrated to whatever
the driver model folks find acceptable, I'll happily follow suit.
