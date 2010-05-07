From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 7 May 2010 11:04:07 +0100
Message-ID: <20100507100406.GA21498__17124.0374482752$1273226764$gmane$org@rakim.wolfsonmicro.main>
References: <20100505185225.GA4411@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
	<m2oa55d774e1005051356n3610d780ra42200c1785e02bd@mail.gmail.com>
	<20100505234025.GB4838@opensource.wolfsonmicro.com>
	<l2kd6200be21005052125rc43217a2r8c65bc98e7a5d3d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <l2kd6200be21005052125rc43217a2r8c65bc98e7a5d3d4@mail.gmail.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 09:25:18PM -0700, Arve Hj=F8nnev=E5g wrote:
> On Wed, May 5, 2010 at 4:40 PM, Mark Brown

> > This really does depend heavily on system design and the intended
> > function of the suspend on the part of the initiator. =A0In many systems
> > suspend will remove sufficient power to stop audio running even if it
> > were desired, and there's the idea with existing manually initiated
> > suspends that the system should stop what it's doing and go into a low
> > power, low responsiveness state. =A0Some systems will initiate a suspend
> > with active audio paths (especially those to or from the AP) which they
> > expect to be stopped.

> You can support both in the same driver in some cases (without a
> switch). If the hardware cannot wake the system when it needs more
> audio buffers, then the driver needs to block suspend while audio is
> playing. Since suspend blockers only block opportunistic suspend, the
> driver can also implement suspend to stop audio playback and it will
> only be called for forced suspend.

As discussed elsewhere in the thread a suspend blocker is not desirable
here - the AP is not doing anything useful on a voice call so blocking
the suspend will just waste power unless runtime PM is good enough to
mean opportunistic suspend isn't adding anything anyway.  It will avoid
the immediate issue with loosing audio but it's not really what we want
to happen.
