From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 7 May 2010 12:21:03 +0100
Message-ID: <20100507112102.GC21498__41131.7660510123$1273231321$gmane$org@rakim.wolfsonmicro.main>
References: <20100505185225.GA4411@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
	<m2oa55d774e1005051356n3610d780ra42200c1785e02bd@mail.gmail.com>
	<20100505234025.GB4838@opensource.wolfsonmicro.com>
	<l2kd6200be21005052125rc43217a2r8c65bc98e7a5d3d4@mail.gmail.com>
	<20100507100406.GA21498@rakim.wolfsonmicro.main>
	<w2kd6200be21005070357r9aad2896l355168a23bf85eae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <w2kd6200be21005070357r9aad2896l355168a23bf85eae@mail.gmail.com>
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

On Fri, May 07, 2010 at 03:57:37AM -0700, Arve Hj=F8nnev=E5g wrote:
> 2010/5/7 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > As discussed elsewhere in the thread a suspend blocker is not desirable
> > here - the AP is not doing anything useful on a voice call so blocking
> > the suspend will just waste power unless runtime PM is good enough to
> > mean opportunistic suspend isn't adding anything anyway. =A0It will avo=
id
> > the immediate issue with loosing audio but it's not really what we want
> > to happen.

> I was talking about audio from the AP. Why would you ever turn off
> another core's audio path on suspend?

This goes back to the thing about a full system suspend being a
sledgehammer which doesn't give enough information about what's going
on when it's used like this.  As discussed we need a way to know that
the connections involved are able to stay live during suspend (on a
large proportion of systems suspend is going to mean that the relevant
bits of the board will loose power so need to be shut down) and that
that the intention of the user is that they should do so (this isn't
clear in the general system, especially not if the suspend is initiated
manually).  =


With a runtime PM approach this is trivial - we just turn off anything
that isn't in use at the current time.  I'll need to extend ASoC to add
information about what to do on suspend to the existing power data.
