From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 21:05:32 -0700
Message-ID: <20100805040532.GB2491__18496.5411470786$1280981269$gmane$org@linux.vnet.ibm.com>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<201008042251.08266.rjw@sisk.pl>
	<20100804205654.GA4986@srcf.ucam.org>
	<AANLkTi=fH=XqJ0QgaMwPr5efacWAFo5h0khD7RjL4n8L@mail.gmail.com>
	<20100805023939.GA2987@linux.vnet.ibm.com>
	<AANLkTim9jaCb3NyRwsLNv5thGKOqpbWX_5vL8TPrtA0b@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim9jaCb3NyRwsLNv5thGKOqpbWX_5vL8TPrtA0b@mail.gmail.com>
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
Cc: david@lang.hm, peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 04, 2010 at 07:46:56PM -0700, Brian Swetland wrote:
> 2010/8/4 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> > On Wed, Aug 04, 2010 at 03:08:33PM -0700, Arve Hj=F8nnev=E5g wrote:
> >> On Wed, Aug 4, 2010 at 1:56 PM, Matthew Garrett <mjg59@srcf.ucam.org> =
wrote:
> >
> > [ . . . ]
> >
> >> > having this conversation? :) It'd be good to have some feedback from
> >> > Google as to whether this satisfies their functional requirements.
> >>
> >> That is "this"? The merged code? If so, no it does not satisfy our
> >> requirements. The in kernel api, while offering similar functionality
> >> to the wakelock interface, does not use any handles which makes it
> >> impossible to get reasonable stats (You don't know which pm_stay_awake
> >> request pm_relax is reverting). The proposed in user-space interface
> >> of calling into every process that receives wakeup events before every
> >> suspend call is also not compatible with existing apps.
> >
> > I should have asked this earlier... =A0What exactly are the apps'
> > compatibility constraints? =A0Source-level APIs? =A0Byte-code class-lib=
rary
> > invocations? =A0C/C++ dynamic linking? =A0C/C++ static linking (in other
> > words, syscall)?
> =

> For Java/Dalvik apps, the wakelock API is pertty high level -- it
> talks to a service via RPC (Binder) that actually interacts with the
> kernel.  Changing the basic kernel<->userspace interface (within
> reason) is not unthinkable.  For example, Arve's suspend_blocker patch
> provides a device interface rather than the proc interface the older
> wakelock patches use.  We'd have to make some userspace changes to
> support that but they're pretty low level and minor.
> =

> In the current model, only a few processes need to specifically
> interact with the kernel (the power management service in the
> system_server, possibly the media_server and the radio interface
> glue).  A model where every process needs to have a bunch of
> instrumentation is not very desirable from our point of view.  We
> definitely do need reasonable statistics in order to enable debugging
> and to enable reporting to endusers (through the Battery Usage UI)
> what's keeping the device awake.

Thank you for the info!

							Thanx, Paul
