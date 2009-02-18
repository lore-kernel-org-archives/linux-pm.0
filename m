From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 09:20:02 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203772616FE__11013.5250412442$1234970912$gmane$org@dlee02.ent.ti.com>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
	<20090216145948.6fea81c3@infradead.org>
	<200902170019.40599.rjw@sisk.pl>
	<20090216232329.GA15678@srcf.ucam.org>
	<20090217142001.GB12378@bulgaria.corp.google.com>
	<20090217064630.688bf639@infradead.org>
	<20090217145141.GA26158@srcf.ucam.org>
	<20090217065622.3e0a9956@infradead.org>
	<20090218151529.GB15195@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090218151529.GB15195@srcf.ucam.org>
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
To: Matthew Garrett <mjg@redhat.com>, Arjan van de Ven <arjan@infradead.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Uli Luckas <u.luckas@road.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> > so use range timers / timer slack for those apps that you do not trust.
> > That is not a big deal, and solves the issue of timer wakeups...
>
> So have userspace say something like "The screen is turned off now,
> change the timer precision on all untrusted userland to sub 10 seconds"?
> That would work.

I also made a similar comment in thread to Arjan yesterday.

He did respond saying there was a pctrl to hit this.  If it's a big list it might be messy.  Unless it can be global.  Probably would be good to look at code rather than speculate.
