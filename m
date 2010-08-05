From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take two
Date: Thu, 5 Aug 2010 16:35:41 -0700
Message-ID: <20100805233541.GV2447__16714.8563582034$1281051499$gmane$org@linux.vnet.ibm.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100804195704.GA23681@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008050616340.25170@asgard.lang.hm>
	<AANLkTi=wyD-K35vQdhTr7kt4wHeEDkbvzkXHAOyMtzZJ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=wyD-K35vQdhTr7kt4wHeEDkbvzkXHAOyMtzZJ@mail.gmail.com>
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
Cc: david@lang.hm, peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 05, 2010 at 06:37:15AM -0700, Brian Swetland wrote:
> On Thu, Aug 5, 2010 at 6:18 AM,  <david@lang.hm> wrote:
> > On Wed, 4 Aug 2010, Paul E. McKenney wrote:
> >
> >> Continuing to rush in where angels fear to tread...
> >
> > here here :-)
> >
> >> o =A0 =A0 =A0 "PM-driving application" are applications that are permi=
tted
> >> =A0 =A0 =A0 =A0to acquire suspend blockers on Android. =A0Verion 8 of =
the
> >> =A0 =A0 =A0 =A0suspend-blocker patch seems to use group permissions to=
 determine
> >> =A0 =A0 =A0 =A0which applications are classified as power aware. =A0Mo=
re generally,
> >> =A0 =A0 =A0 =A0PM-driving applications seem to be those that have perm=
ission
> >> =A0 =A0 =A0 =A0to exert some control over the system's sleep state.
> >>
> >> =A0 =A0 =A0 =A0Note that an application might be power-oblivious on on=
e Android
> >> =A0 =A0 =A0 =A0device and PM-driving on another, depending on whether =
the user
> >> =A0 =A0 =A0 =A0allows that application to acquire suspend blockers. =
=A0The
> >> =A0 =A0 =A0 =A0classification might even change over time. =A0For exam=
ple, a
> >> =A0 =A0 =A0 =A0user might give an application PM-driving status initia=
lly,
> >> =A0 =A0 =A0 =A0but change his or her mind after some experience with t=
hat
> >> =A0 =A0 =A0 =A0application.
> >
> > One thing that I think it's important to document here is theinformation
> > that Brian provided in response to your question about how many (or act=
ually
> > how few) applications fall into this catefory
> =

> I think I need to clarify here.  When I say "app" in the context of
> Android, I mean "an application running under the Android app model --
> sandboxed under a per-app or app-group uid", not "a process".  The
> vast majority of processes on an Android device are "apps" in this
> sense, but some (usually low level services or daemons) are not.  Also
> I use "wakelock" as a place holder for "suspend blocker" or whatever
> exact API we're trying to hash out here, because it's shorter and I'm
> lazy.
> =

> Any app may obtain a wakelock through the standard Android APIs,
> provided it has permission to do so.  In the current implementation,
> apps obtain wakelocks via making a binder RPC call to the power
> manager service which tracks high level wakelocks (for apps!) and
> backs them by a single kernel wakelock.  Access control is at the RPC
> level.  This implementation could be changed to have the app API
> simply open /dev/suspendblock or whatnot, with access control enforced
> by unix permissions (the framework would arrange for apps with the
> android "can block sleep" permission to be in a unix group that has
> access to the device).
> =

> For native services (native daemons that run "underneath" the android
> app framework -- for example the media service, the radio interface,
> etc), the kernel interface is used directly (ok, usually via a very
> thin C convenience wrapper).

Thank you for the added detail on Android user-space operation!!!

							Thanx, Paul

> Brian
> =

> =

> > Quote:
> >
> >> I should have asked this earlier... =A0What exactly are the apps'
> >> compatibility constraints? =A0Source-level APIs? =A0Byte-code class-li=
brary
> >> invocations? =A0C/C++ dynamic linking? =A0C/C++ static linking (in oth=
er
> >> words, syscall)?
> >
> > For Java/Dalvik apps, the wakelock API is pertty high level -- it
> > talks to a service via RPC (Binder) that actually interacts with the
> > kernel. =A0Changing the basic kernel<->userspace interface (within
> > reason) is not unthinkable. =A0For example, Arve's suspend_blocker patch
> > provides a device interface rather than the proc interface the older
> > wakelock patches use. =A0We'd have to make some userspace changes to
> > support that but they're pretty low level and minor.
> >
> > In the current model, only a few processes need to specifically
> > interact with the kernel (the power management service in the
> > system_server, possibly the media_server and the radio interface
> > glue). =A0A model where every process needs to have a bunch of
> > instrumentation is not very desirable from our point of view. =A0We
> > definitely do need reasonable statistics in order to enable debugging
> > and to enable reporting to endusers (through the Battery Usage UI)
> > what's keeping the device awake.
> >
> > Brian
> >
> >
