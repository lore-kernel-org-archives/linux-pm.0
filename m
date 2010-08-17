From: "Ted Ts'o" <tytso@mit.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Mon, 16 Aug 2010 20:20:32 -0400
Message-ID: <20100817002032.GD21182__9059.25472402505$1282004531$gmane$org@thunk.org>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<Pine.LNX.4.44L0.1008120733130.21006-100000@netrider.rowland.org>
	<AANLkTinMwt27wuDUh32F36wpoC54Syzp1_nK9UCxYmEK@mail.gmail.com>
	<20100812125248.GA2763@thunk.org>
	<20100814075000.GB27430@elf.ucw.cz>
	<20100816081655.3e9e29f7@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100816081655.3e9e29f7@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 16, 2010 at 08:16:55AM -0700, Jesse Barnes wrote:
> Fortunately in this case the problem doesn't seem to be fatal.  We've
> already established that the userland API portion of suspend blockers
> could be implemented in userspace with a bit more work, given that the
> kernel problems with suspend/resume and events are addressed.
> Hopefully Google is already developing a prototype userspace
> implementation to make sure it's workable; being able to build stock
> upstream kernels for my Droid and its Android userspace sure would be
> nice.

You know, you don't have to wait for the Android engineers to do this
work.  You (or others who want to be able to use stock upstream kernel
with Android devices) could just as easily try to do the "bit more
work" yourselves --- that is, do the open souce thing and scratch
one's own itch.

After all, Rafael is saying he's refusing to accept patches (or
implement) in-kernel oppunsitic suspend for upstream unless it's
proven to him that a userspace implementation isn't sufficient.  It
might be just as fair for the Android userspace upstream to refuse to
accept (or engineer) userspace changes unless it is proven that the
userspace version of opporunistic suspend is just as good as the
in-kernel version which is successfully been deployed in millions and
millions of shipping units today...

Speaking personally, it's not clear to me how waking up a userspace
suspend daemon and waiting for it to get scheduled will result in
better power savings than simply handling it in the kernel, but as
soon as someone is willing to do the work, we can find out for sure
who is right.

					- Ted
