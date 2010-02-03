From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH] PM: disable nonboot cpus before
	suspending devices
Date: Wed, 3 Feb 2010 15:08:03 -0800
Message-ID: <20100203150803.5a4b37fe.akpm__25087.6573300504$1265238624$gmane$org@linux-foundation.org>
References: <alpine.LFD.2.00.1001221841490.2266@localhost>
	<201002030244.23989.rjw@sisk.pl>
	<20100202174853.67eeccdd.akpm@linux-foundation.org>
	<201002032334.37198.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002032334.37198.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Benjamin@smtp1.linux-foundation.org, linux-kernel@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 3 Feb 2010 23:34:37 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Wednesday 03 February 2010, Andrew Morton wrote:
> > On Wed, 3 Feb 2010 02:44:23 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > +static inline gfp_t clear_gfp_allowed_mask(gfp_t mask)
> > > +{
> > > +	gfp_t ret = gfp_allowed_mask;
> > > +	gfp_allowed_mask &= ~mask;
> > > +	return ret;
> > > +}
> > 
> > Fair enuf.
> > 
> > Of course, this is all horridly racy/buggy without locking.  Would I be
> > correct in hoping that all the callers happen when the system is in
> > everyone-is-frozen mode?
> 
> As far as I can tell, gfp_allowed_mask is only touched during init apart from
> this.

Well yes - the new interfaces are the problem - they're racy!

> > Perhaps we should add some documentation (or even an assertion) to
> > prevent someone from using these interfaces from within normal code.
> 
> I thought about that, but didn't invent anything smart enough.
> 
> Well, maybe except for a comment like "this must be called with pm_mutex held",
> because that's the only case when it would be really safe.

Is that the locking rule?  My above guess was incorrect?

Maybe slip a

	BUG_ON(!mutex_is_locked(&pm_mutex));

in there?
