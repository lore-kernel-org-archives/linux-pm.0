From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Thu, 26 Feb 2009 22:36:08 +0100
Message-ID: <20090226213608.GB2214@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902112323.53421.rjw@sisk.pl>
	<d6200be20902111542r3592f64dt41a282221aed1268@mail.gmail.com>
	<200902122322.30864.rjw@sisk.pl>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org>
	<20090226150430.GA1398@ucw.cz>
	<d6200be20902261311q103641dap57425fc8e49cd549@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902261311q103641dap57425fc8e49cd549@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: "ncunningham@crca.org.au" <ncunningham@crca.org.au>, "u.luckas@road.de" <u.luckas@road.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "swetland@google.com" <swetland@google.com>
List-Id: linux-pm@vger.kernel.org

On Thu 2009-02-26 13:11:05, Arve Hj?nnev?g wrote:
> On Thu, Feb 26, 2009 at 7:04 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> > It is discouraging to hear comments like "we have been talking about for years something else" yet nothing exists or is in open development. Things can evolve in place.
> >>
> >> This is userlad-visible ABI. We can't evolve it in place - we need to
> >> get it right before merging it, otherwise we need to carry on
> >> maintaining code for an extended period of time in order to ensure that
> >> there's no userland code that depends on it.
> >
> > Plus... sleepy patches showed that autosuspend can be done *without*
> > new userland ABIs.
> 
> As far as I can tell the sleepy patches tries to enter suspend if the
> system is idle. If you plan to wake back up for the first timer, then
> the end result of this is the same as what we get by entering the low
> power state from arch_idle in the msm platform. Due to the frequent
> wakeups, the power use is higher than our suspend state. If you don't
> wake up on the first timer, you need something like the wakelock api
> so apps specify that they need to run even if they were inactive for 3
> seconds.

You understand it right... it wakes up on first event. So you
eliminate all the timers that fire too often... and fix userspace if
neccessary.

Given that your 3rd party apps are written in java, you should have
enough control over them.

What in-kernel timers are causing problems for you? For how long can
Android sleep?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
