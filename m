From: mark gross <mgross@linux.intel.com>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 16:52:57 -0800
Message-ID: <20090218005257.GC26292__33915.7091839754$1234918397$gmane$org@linux.intel.com>
References: <13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
	<20090216145948.6fea81c3@infradead.org>
	<200902170019.40599.rjw@sisk.pl>
	<20090216232329.GA15678@srcf.ucam.org>
	<20090217142001.GB12378@bulgaria.corp.google.com>
	<20090217064630.688bf639@infradead.org>
	<20090217145141.GA26158@srcf.ucam.org>
	<20090217065622.3e0a9956@infradead.org>
	<13B9B4C6EF24D648824FF11BE896716203771DD342@dlee02.ent.ti.com>
	<20090217160421.12bc851f@infradead.org>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090217160421.12bc851f@infradead.org>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Brian Swetland <swetland@google.com>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 17, 2009 at 04:04:21PM -0800, Arjan van de Ven wrote:
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
> You can *directly* throttle the number of wakeups an application causes
> that way to a value you set.
> 

As the application code is mostly managed it should be a slam dunk to
make range timers work withing the android framework or Dalvik layers.

--mgross
