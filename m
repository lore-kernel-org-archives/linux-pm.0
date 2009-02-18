From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 18:18:59 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203772614AD__14190.596729941$1234916556$gmane$org@dlee02.ent.ti.com>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
	<20090216145948.6fea81c3@infradead.org>	<200902170019.40599.rjw@sisk.pl>
	<20090216232329.GA15678@srcf.ucam.org>
	<20090217142001.GB12378@bulgaria.corp.google.com>
	<20090217064630.688bf639@infradead.org>
	<20090217145141.GA26158@srcf.ucam.org>
	<20090217065622.3e0a9956@infradead.org>
	<13B9B4C6EF24D648824FF11BE896716203771DD342@dlee02.ent.ti.com>
	<20090217160421.12bc851f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090217160421.12bc851f@infradead.org>
Content-Language: en-US
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Uli Luckas <u.luckas@road.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> On Tue, 17 Feb 2009 09:32:46 -0600
> "Woodruff, Richard" <r-woodruff2@ti.com> wrote:
>
> > > so use range timers / timer slack for those apps that you do not
> > > trust. That is not a big deal, and solves the issue of timer
> > > wakeups...
> >
> > I not so sure it is that straight forward in practice.  End systems
> > integrate a lot of 3rd party software who view performance 1st and
> > have no thought of power.
>
> you know that with the range timers/slack, you can control the
> "rounding" of the timer of the application, right?

I've not explored user space for this.

Can on a per-application basis some controlling application cause timers of a target process to be rounded or is it global? Or do you need to link the new application to use special glib variants (as described in OLS papers a few years ago)?

> You can *directly* throttle the number of wakeups an application causes
> that way to a value you set.

Are you talking about your work as seen in lwn.net summary?

http://lwn.net/Articles/296578/

Your change here does look like something which could be used to control timers.  Don't you still need some dynamic way to set the fuzz/slack if its globally applied?  It seems like you might want some timers precise and others fuzzy.

Would the holding of a wakelock or some activity counter be a good trigger for switching rounding time?  If wakelocks held "minor adjustment" else "major adjustment"

Thanks for the good pointer assuming I understood it in quick scan.

Thanks,
Richard W.
