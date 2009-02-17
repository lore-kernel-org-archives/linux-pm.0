From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 06:56:22 -0800
Message-ID: <20090217065622.3e0a9956__30171.2639899508$1234882860$gmane$org@infradead.org>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
	<20090216145948.6fea81c3@infradead.org>
	<200902170019.40599.rjw@sisk.pl>
	<20090216232329.GA15678@srcf.ucam.org>
	<20090217142001.GB12378@bulgaria.corp.google.com>
	<20090217064630.688bf639@infradead.org>
	<20090217145141.GA26158@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090217145141.GA26158@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Brian Swetland <swetland@google.com>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Oliver@smtp1.linux-foundation.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Feb 2009 14:51:41 +0000
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Tue, Feb 17, 2009 at 06:46:30AM -0800, Arjan van de Ven wrote:
> 
> > actually with powertop... on the open source side things are
> > actually won. It took all of 6 months...
> > I don't see that as a valid excuse. In fact, if this kind of
> > solution makes real userspace scheduled timers to be missed then I
> > consider it a serious functionality misfeature.
> 
> Remember that Android has an open marketplace designed to appeal to
> Java programmers - users are going to end up downloading code from
> there and then blaming the platform if their battery life heads
> towards zero. I think "We can't trust our userland not to be dumb" is
> a valid concern.

so use range timers / timer slack for those apps that you do not trust.
That is not a big deal, and solves the issue of timer wakeups...


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
