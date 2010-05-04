From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 4 May 2010 22:44:16 +0200
Message-ID: <201005042244.16208.rjw__46207.9286612154$1273006000$gmane$org@sisk.pl>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87r5lrh780.fsf@deeprootsystems.com>
	<201005042223.41370.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005042223.41370.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 04 May 2010, Rafael J. Wysocki wrote:
> On Tuesday 04 May 2010, Kevin Hilman wrote:
> > Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> > =

> > > On Mon, May 03, 2010 at 05:43:34PM -0700, Brian Swetland wrote:
> > >> On Mon, May 3, 2010 at 5:09 PM, Arve Hj=F8nnev=E5g <arve@android.com=
> wrote:
> > >> > On Mon, May 3, 2010 at 4:37 PM, Kevin Hilman
> > >
> > >> >> This last point is especially troubling.  I don't find it a comfo=
rting
> > >> >> path to go down if the drivers have to start caring about which PM
> > >> >> policy is currently in use.
> > >
> > >> I'll echo Arve here -- all drivers should seek to be in the lowest
> > >> power state possible at all times.  We've never suggested that
> > >> suspend_block is a substitute for that.
> > >
> > > Looking at this from a subsystem/driver author point of view the prob=
lem
> > > I'm faced with is that as a result of using system suspend much more
> > > aggressively the subsystem and driver layers are getting conflicting
> > > instructions about what the lowest power state possible is.
> > =

> > Exactly.
> > =

> > With runtime PM, there is flexibility in choosing the lowest power
> > state at the device/subsystem level, based on activity, timeouts,
> > bitrate, dependencies, latency/throughput constraints, etc.
> > =

> > With opportunistic suspend, all of this flexibility is gone, and the
> > device/subsystem is told to go into the lowest power, highest latency
> > state, period.
> =

> Guys, please.
> =

> The opportunistic suspend feature is _not_ to replace runtime PM by any m=
eans!
> =

> However, there are situations in which runtime PM is clearly insufficient.
> The idea behind runtime PM is that subsystems and device drivers will know
> when to put devices into low power states and save energy this way.  Stil=
l,
> even if all subsystems do that 100% efficiently, there may be more savings
> possible by putting the entire system into a sleep state (like on ACPI-ba=
sed
> PCs) and we can reach there by runtime PM alone.

s/can/can't/; s/reach/go/

Rafael
