From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: disable nonboot cpus before
	suspending devices
Date: Wed, 3 Feb 2010 23:34:37 +0100
Message-ID: <201002032334.37198.rjw__39385.7364812449$1265236577$gmane$org@sisk.pl>
References: <alpine.LFD.2.00.1001221841490.2266@localhost>
	<201002030244.23989.rjw@sisk.pl>
	<20100202174853.67eeccdd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100202174853.67eeccdd.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 03 February 2010, Andrew Morton wrote:
> On Wed, 3 Feb 2010 02:44:23 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > +static inline gfp_t clear_gfp_allowed_mask(gfp_t mask)
> > +{
> > +	gfp_t ret = gfp_allowed_mask;
> > +	gfp_allowed_mask &= ~mask;
> > +	return ret;
> > +}
> 
> Fair enuf.
> 
> Of course, this is all horridly racy/buggy without locking.  Would I be
> correct in hoping that all the callers happen when the system is in
> everyone-is-frozen mode?

As far as I can tell, gfp_allowed_mask is only touched during init apart from
this.

> Perhaps we should add some documentation (or even an assertion) to
> prevent someone from using these interfaces from within normal code.

I thought about that, but didn't invent anything smart enough.

Well, maybe except for a comment like "this must be called with pm_mutex held",
because that's the only case when it would be really safe.

Rafael
