From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Sat, 2 Sep 2006 13:17:40 +0200
Message-ID: <20060902111740.GB1178@elf.ucw.cz>
References: <20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
	<1155806337.30834.17.camel@localhost>
	<20060817214031.GE6450@ucw.cz> <1155901719.3659.43.camel@localhost>
	<20060824075939.GF1952@elf.ucw.cz>
	<1156935653.10909.69.camel@localhost>
	<20060830223654.GE3923@elf.ucw.cz>
	<1157031852.10909.157.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1157031852.10909.157.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Amit Kucheria <amit.kucheria@nokia.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

On Thu 2006-08-31 16:44:12, Amit Kucheria wrote:
> On Thu, 2006-08-31 at 00:36 +0200, ext Pavel Machek wrote:
> > On Wed 2006-08-30 14:00:53, Amit Kucheria wrote:
> > > But PowerOP would allow SoC-based systems to tune the operating points
> > > to get the most out of their top-10 use-cases and sleep modes.
> > =

> > Question is: can we get similar savings without ugly interface powerop
> > presents?
> =

> If I have understood correctly, your main objection is to defining new
> operating points from userspace?

Well, that is big objection, but not my main one. I believe that "new
operating points from userspace" are non-starter. "So obviously wrong
that noone would merge that".

> The only other interface is the actually setting of a (named) operating
> point and that is _required_ to do anything useful.

No, they are not.

We already have interface for selecting cpu frequency. Lets keep it.

We may need new interface for selecting DSP frequency. If that is
needed, lets *add* that interface.

We may need new interface to say if usb needs to be enabled or
not. How to do that interface right is a question, but lets say we
*add* that interface.

Now, it should be up-to the powerop framework to select best operating
point given "cpu speed, dsp speed, usb on/off" state. But I argue that
this should be done in-kernel and hidden from user.

> > Is there anything cpufreq can't do?
> =

> - Embedded systems _want_ to deal with performance/power management in
> terms of Operating Points that encapsulate the complete state of the SoC
> (core speeds, voltages, buses speeds, etc.) instead of only CPU
> frequency.

I'm not saying we'll not have complete-SoC-state at some layer. But I
do not think we want it at userspace-kernelspace interface.

> - There is not much in cpufreq for handling rate propagation and
> dependency tracking for clocks and voltages. This is what the clock
> framework and the upcoming voltage framework handle quite well.

Good.

> - Most implementations of cpufreq drivers have a fixed rate table (freq,
> voltage). With rate propagation and dependencies in SoCs, available
> rates can vary dynamically based on states of various cores,
> peripherals, etc.

But that's cpufreq-implementation-detail, right?
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
