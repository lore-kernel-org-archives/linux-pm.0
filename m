From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 19:39:39 -0700
Message-ID: <20100805023939.GA2987__37556.4191178002$1280976032$gmane$org@linux.vnet.ibm.com>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<201008042251.08266.rjw@sisk.pl>
	<20100804205654.GA4986@srcf.ucam.org>
	<AANLkTi=fH=XqJ0QgaMwPr5efacWAFo5h0khD7RjL4n8L@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=fH=XqJ0QgaMwPr5efacWAFo5h0khD7RjL4n8L@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 04, 2010 at 03:08:33PM -0700, Arve Hj=F8nnev=E5g wrote:
> On Wed, Aug 4, 2010 at 1:56 PM, Matthew Garrett <mjg59@srcf.ucam.org> wro=
te:

[ . . . ]

> > having this conversation? :) It'd be good to have some feedback from
> > Google as to whether this satisfies their functional requirements.
> =

> That is "this"? The merged code? If so, no it does not satisfy our
> requirements. The in kernel api, while offering similar functionality
> to the wakelock interface, does not use any handles which makes it
> impossible to get reasonable stats (You don't know which pm_stay_awake
> request pm_relax is reverting). The proposed in user-space interface
> of calling into every process that receives wakeup events before every
> suspend call is also not compatible with existing apps.

I should have asked this earlier...  What exactly are the apps'
compatibility constraints?  Source-level APIs?  Byte-code class-library
invocations?  C/C++ dynamic linking?  C/C++ static linking (in other
words, syscall)?

							Thanx, Paul
