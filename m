From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Tue, 12 May 2009 22:40:32 +0200
Message-ID: <200905122240.33384.rjw__11912.8748694949$1242161101$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905121852.37224.rjw@sisk.pl>
	<20090512105059.30fb93c2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090512105059.30fb93c2.akpm@linux-foundation.org>
Content-Disposition: inline
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
Cc: kernel-testers@vger.kernel.org, mel@csn.ul.ie, rientjes@google.com, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 12 May 2009, Andrew Morton wrote:
> On Tue, 12 May 2009 18:52:36 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Well, what about the following?
> 
> It has the virtue of simplicity.
> 
> > +static inline void disable_oom_killer(void)
> > +{
> > +	oom_killer_disabled = true;
> > +}
> > +
> > +static inline void enable_oom_killer(void)
> > +{
> > +	oom_killer_disabled = false;
> > +}
> 
> I'll change these to oom_killer_disable() and oom_killer_enable(), OK?

Works for me, thanks!
