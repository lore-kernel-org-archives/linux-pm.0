From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 14:36:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005051432120.1885-100000__17038.8861479752$1273084626$gmane$org@iolanthe.rowland.org>
References: <20100505173337.GA1671@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505173337.GA1671@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 5 May 2010, Matthew Garrett wrote:

> On Wed, May 05, 2010 at 02:56:22PM +0100, Mark Brown wrote:
> 
> > If the conclusion is that we don't have anything generic within the
> > kernel then it'd be good to at least have this explicitly spelled out so
> > that we're clear what everyone thinks is going on here and how things
> > are supposed to work.  At the minute it doesn't feel like we've had the
> > discussion so we could end up working at cross purposes.  I don't want
> > to end up in the situation where I have to work around the APIs I'm
> > using without the relevant maintainers having sight of that since that
> > not only am I likely to be missing some existing solution to the problem
> > but is also prone to causing problems maintaining the underlying API.
> 
> We seem to have ended up managing most of our PM infrastructure 
> iteratively. If the concern is more about best practices than intrinsic 
> incompatibilities, I'd lean towards us being better off merging this now 
> and then working things out over the next few releases as we get a 
> better understanding of the implications. The main thing that we have to 
> get right in the short term is the userspace API - everything else is 
> easier to fix up as we go along.

This particular question could use a little more discussion.  I'm
interested to know, for example, under what conditions you would or
would not want to shut down an autonomous codec while going into system 
suspend on a cell phone.

Clearly if there's a call in progress you don't want to shut the codec
down.  Are there any other circumstances?  Would they vary according to
whether the suspend was forced or opportunistic?

In short, I'm trying to get at how much information drivers _really_ 
need to have about the reason for a system suspend.

Alan Stern
