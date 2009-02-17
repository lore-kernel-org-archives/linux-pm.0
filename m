From: Brian Swetland <swetland@google.com>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 07:28:11 -0800
Message-ID: <20090217152811.GA12686__35997.2672573805$1234884774$gmane$org@bulgaria.corp.google.com>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
	<20090216145948.6fea81c3@infradead.org>
	<200902170019.40599.rjw@sisk.pl>
	<20090216232329.GA15678@srcf.ucam.org>
	<20090217142001.GB12378@bulgaria.corp.google.com>
	<20090217064630.688bf639@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090217064630.688bf639@infradead.org>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

[Arjan van de Ven <arjan@infradead.org>]
> On Tue, 17 Feb 2009 06:20:01 -0800
> Brian Swetland <swetland@google.com> wrote:
> 
> > Of course that still doesn't address userspace.  Aggressively going to
> > suspend lets us compensate for userspace programs that do somewhat
> > silly things (I agree that it would be best if they didn't but they
> > do and getting *everyone* to write their userspace code to avoid
> > spinning or avoid waking up on short-duration timers to poll is a
> > losing battle).
> 
> actually with powertop... on the open source side things are actually
> won. It took all of 6 months...
> I don't see that as a valid excuse. In fact, if this kind of solution
> makes real userspace scheduled timers to be missed then I consider it a
> serious functionality misfeature.

While you can't expect the kernel to solve all the problems of
userspace, here's the broad situation one could end up in
(note this specific sequence is generic and not based on any one
specific product experience):

- carrier deploys a device 
- carrier agrees to allow installation of arbitrary third party apps
  without some horrible certification program requiring app authors
  to jump through hoops, wait ages for approval, etc
- users rejoice and install all kinds of apps
- some apps are poorly written and impact battery life
- users complain to carrier about battery life

You will end up with some crappy apps that do really dumb things.
However, even if they're badly written users may still install and use
these apps because hey, they do something the user likes.

>From the Android standpoint, we're trying to balance protecting the
system from poorly designed apps and somehow letting the user know "hey
app X is chewing up a lot of power" (work in progress on this).

While I'd love for every app developer to actively tune their apps for a
good mobile experience, I am skeptical that this is going to happen.

Brian
