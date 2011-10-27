From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Problem statement: Opportunistic suspend and i8042
	wakeups
Date: Wed, 26 Oct 2011 22:47:26 -0700
Message-ID: <20111027054726.GE15725__42229.5357835994$1319694463$gmane$org@core.coreip.homeip.net>
References: <CAMLZHHQH=vWDnQH-Gnz01yDFv=wqG1de5nezb2B+H6VSJieg5A@mail.gmail.com>
	<20111010203815.GA25314@core.coreip.homeip.net>
	<CAMLZHHTjZdxiRsEP=tQyQafkPHftOtq6XRgd09MdCJowSxKCvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAMLZHHTjZdxiRsEP=tQyQafkPHftOtq6XRgd09MdCJowSxKCvA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-pm@lists.linux-foundation.org, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 13, 2011 at 03:25:04PM +0100, Daniel Drake wrote:
> Hi,
> 
> Thanks for not getting bored of this :)
> 
> On Mon, Oct 10, 2011 at 9:38 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > I think input layer releasing keys at resume time is actually in the
> > wrong here, as it meddles with device state after physical device
> > (i8042, atkbd, etc) are fully woken up.
> 
> Yes, that's whats happening here.
> 
> > IIRC I put releasing originally in resume because I was concerned
> > with events getting discarded after S2D because we thew away the state
> > that happens after taking snapshot and there weren't enough granularity
> > in PM callbacks to differentiate between S2D and S2R.
> >
> > I believe if we move release of the keys into suspend handlers then
> > input core should not get into the middle of things for your case as you
> > said that the OLPC device will not suspend with a key still pressed and
> > upon release we would not be doing anything with key state (but
> > restore LED/SOUND only) which you do not care about.
> 
> Not quite.
> 
> The system will suspend, but will resume immediately (because of an
> incoming key press interrupt, which are repeated when the key is held
> down).

Ah, I thought it won't even attempt to suspend while key is depressed.

> So, if Linux fabricates a key release event in the suspend
> handler, userspace would see two key release events: the fabricated
> one, and the one that comes from when the user later releases the key
> resulting in a break interrupt.  This would cause two characters to be
> printed on screen when the user only pressed the key once.

Input core will suppress the 2nd release though so I do not think that
userspace will see it.

Thanks.

-- 
Dmitry
