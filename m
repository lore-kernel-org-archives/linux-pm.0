From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Thu, 7 May 2009 21:33:47 +0200
Message-ID: <200905072133.48917.rjw__24735.5258827612$1241724944$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905072009.53406.rjw@sisk.pl>
	<20090507114807.d7c6d26a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507114807.d7c6d26a.akpm@linux-foundation.org>
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
Cc: kernel-testers@vger.kernel.org, rientjes@google.com, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 07 May 2009, Andrew Morton wrote:
> On Thu, 7 May 2009 20:09:52 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > > > > I'm suspecting that hibernation can allocate its pages with
> > > > > __GFP_FS|__GFP_WAIT|__GFP_NORETRY|__GFP_NOWARN, and the page allocator
> > > > > will dtrt: no oom-killings.
> > > > > 
> > > > > In which case, processes_are_frozen() is not needed at all?
> > > > 
> > > > __GFP_NORETRY alone causes it to fail relatively quickly, but I'll try with
> > > > the combination.
> > > 
> > > OK.  __GFP_WAIT is the big hammer.
> > 
> > Unfortunately it fails too quickly with the combination as well, so it looks
> > like we can't use __GFP_NORETRY during hibernation.
> 
> hm.
> 
> So where do we stand now?
> 
> I'm not a big fan of the global application-specific state change
> thing.  Something like __GFP_NO_OOM_KILL has a better chance of being
> reused by other subsystems in the future, which is a good indicator.

I'm not against __GFP_NO_OOM_KILL, but there's been some strong resistance to
adding new _GPF _FOO flags recently.  Is there any likelihood anyone else we'll
really need it any time soon?

The advantage of the freezer-based approach is that it disables the OOM killer
when it's not going to work anyway, so it looks like a reasonable thing to do
regardless.  IMHO.
