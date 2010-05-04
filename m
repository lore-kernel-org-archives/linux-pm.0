From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 4 May 2010 14:59:07 +0100
Message-ID: <20100504135907.GA3651__10506.3718081967$1272981591$gmane$org@opensource.wolfsonmicro.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl>
	<87sk68r1zh.fsf@deeprootsystems.com>
	<s2qd6200be21005031709r28420f0ezf3cf286517ee9114@mail.gmail.com>
	<w2pa55d774e1005031743x859e82fz401346fae7fe873a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <w2pa55d774e1005031743x859e82fz401346fae7fe873a@mail.gmail.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 03, 2010 at 05:43:34PM -0700, Brian Swetland wrote:
> On Mon, May 3, 2010 at 5:09 PM, Arve Hj=F8nnev=E5g <arve@android.com> wro=
te:
> > On Mon, May 3, 2010 at 4:37 PM, Kevin Hilman

> >> This last point is especially troubling. =A0I don't find it a comforti=
ng
> >> path to go down if the drivers have to start caring about which PM
> >> policy is currently in use.

> I'll echo Arve here -- all drivers should seek to be in the lowest
> power state possible at all times.  We've never suggested that
> suspend_block is a substitute for that.

Looking at this from a subsystem/driver author point of view the problem
I'm faced with is that as a result of using system suspend much more
aggressively the subsystem and driver layers are getting conflicting
instructions about what the lowest power state possible is.

> Suspend blockers give us some flexibility on systems where runtime pm
> will not get us all the way there. If you can meet your power needs
> without needing suspend blockers, awesome, you don't need them on that
> platform.  The patchset Arve sent out makes this feature an
> off-by-default kernel configuration option that compiles out to no-ops
> when disabled.

I think a big part of this for me is that this approach changes the
intended use of the system-wide suspend a bit, complicating it a bit
further than it already is.  We end up doing a suspend (which in the
normal course of affairs means that the driver should shut everything
down) partly as a substitute for runtime PM on the core system devices
and partly because our runtime PM isn't doing as well as it should on
the individual devices.

I'd be a lot more comfortable with this if it came with a mechanism for
communicating the intended effect of a suspend on a per-device level so
that the drivers have a clear way of figuring out what to do when the
system suspends.  If there isn't one we can add subsystem or driver
specific hooks, of course, but it'd be better to address this at the
system level.

> In our experience, periodic timers and polling, both userspace side
> and kernelside make suspend blockers a win even on platforms like OMAP
> which have pretty flexible hardware power management.  Going to low
> power states in idle results in higher average power consumption than
> going to the same states in full suspend, at least on Android devices
> shipping today.

There's definite work to be done here, yes.
