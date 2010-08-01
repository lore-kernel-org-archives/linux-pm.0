From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 1 Aug 2010 12:12:28 -0700
Message-ID: <20100801191228.GL2470__23163.0907081582$1280690036$gmane$org@linux.vnet.ibm.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100731230101.7cc1d8c7@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 31, 2010 at 11:01:01PM -0700, Arjan van de Ven wrote:
> On Sat, 31 Jul 2010 22:48:16 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Sat, Jul 31, 2010 at 09:52:14PM -0700, Arjan van de Ven wrote:
> > > On Sat, 31 Jul 2010 10:58:42 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > 
> > > > o	"Power-aware application" are applications that are
> > > > permitted to acquire suspend blockers on Android.  Verion 8 of the
> > > > 	suspend-blocker patch seems to use group permissions to
> > > > determine which applications are classified as power aware.
> > > > 
> > > > 	More generally, power-aware applications seem to be those
> > > > that have permission to exert some control over the system's
> > > > 	power state.
> > > 
> > > I don't like the term "Power aware application". An application is
> > > well behaved or it isn't. "aware" has nothing to do with it.
> > 
> > Applications are often complex enough to be aware of some things,
> > naive about others, well behaved in some ways, and ill-behaved in
> > others. This has been the case for some decades now, so it should not
> > come as a surprise.
> 
> I do not like the term "aware". At all.
> It implies "awareness", and implies it does things based on the power
> circumstances.
> 
> It's about *behaving well*. (not polling, not having activity when
> there is nothing to do etc etc). Not about being aware that power
> matters.
> 
> I can write a very shitty application that polls all the time and
> otherwise keeps the CPU and system busy, but it'll be aware that power
> matters.. it just doesn't behave accordingly.

I understand that you would prefer that we group applications into
"good" and "bad" categories, but then again, I suspect that most of us
understood that before you posted this message.  Given your significant
and well-appreciated contributions to power efficiency over the past
several years, I must confess to be quite disappointed that you failed
to do more than to simply restate your preference.

However, your words below are much more to the point, so I will respond
to them.

> > The choice between power-aware and power-naive will depend on who is
> > available to do the programming and how valuable power-awareness is
> > for the application in question.  Given that people who program
> > PC-class applications are much more common than are people who
> > program with energy efficiency in mind, the power-naive choice will
> > be attractive in many cases.
> 
> I'm not sure I buy that.
> 4 years ago.. yes.
> Today.. with PowerTOP and co out there for a long time?
> I don't believe that anymore. Most of our open source PC apps are
> actually very well behaving in the power sense.
> Yes an occasional bug slips in, and then gets fixed quickly.
> (speaking as someone who does this sort of work for a Linux
> distribution... yes bugs happen on a whole distro level, but they're
> also not all that common, and get fixed quickly)

I agree that much progress has been made over the past four years.
My laptop's battery life has increased substantially, with roughly half
of the increase due to software changes.  Taken over all the laptops and
PCs out there, this indeed adds up to substantial and valuable savings.

So, yes, you have done quite well.

However, your reliance on application-by-application fixes, while good
up to a point, is worrisome longer term.  The reason for my concern is
that computing history has not been kind to those who fail to vigorously
automate.  The Android guys have offered up one way of automating power
efficiency.  There might be better ways, but their approach does at
the very least deserve a fair hearing -- and no one who read the recent
LKML discussion of their approach could possibly mistake it for anything
resembling a fair hearing.

And yes, I do understand and appreciate your contributions in the form of
things like timer aggregation, which does automate the otherwise-tricky
task of coordinating power usage across unrelated applications, at
least in some important cases.  But power efficiency will likely require
multiple approaches, especially if the Linux stack is to approach the
power efficiencies provided by dedicated devices.

							Thanx, Paul
