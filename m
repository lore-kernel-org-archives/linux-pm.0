From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 11 May 2010 19:47:19 +0100
Message-ID: <20100511184718.GA8732__48972.3235987642$1273603972$gmane$org@sirena.org.uk>
References: <m2oa55d774e1005051356n3610d780ra42200c1785e02bd@mail.gmail.com>
	<20100505234025.GB4838@opensource.wolfsonmicro.com>
	<l2kd6200be21005052125rc43217a2r8c65bc98e7a5d3d4@mail.gmail.com>
	<20100507100406.GA21498@rakim.wolfsonmicro.main>
	<w2kd6200be21005070357r9aad2896l355168a23bf85eae@mail.gmail.com>
	<20100507112102.GC21498@rakim.wolfsonmicro.main>
	<81818215-44A2-4B74-A43F-E2644C950F5C@mit.edu>
	<20100507122520.GD21498@rakim.wolfsonmicro.main>
	<z2wa55d774e1005070537k8e3cb6baxc74e998e930d254d@mail.gmail.com>
	<20100507133025.GA23983@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100507133025.GA23983@rakim.wolfsonmicro.main>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Theodore Tso <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 07, 2010 at 02:30:25PM +0100, Mark Brown wrote:

> I mean that I will extend the embedded audio subsystem that the kernel
> already has (ASoC, in sound/soc) to support ignoring suspends for some
> audio paths so that they can be kept up during suspend.  This will be
> primarily intended for use with opportunistic suspend but not specific
> to it.

Just for the record I've now done an implementation of this which should
show up in -next when it's rebuilt and 2.6.35.  It's not the most
thoroughly tested code I've ever written but I'm fairly happy it'll do
the right thing, especially for analogue basebands.  The functionality
needs to be explicitly requested by machine drivers so there should be
no impact on systems using suspend in a more standard fashion.

This means that there should be even less of an issue merging this from
an audio point of view.
