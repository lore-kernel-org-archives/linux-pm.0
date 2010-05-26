From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 19:28:24 +0200
Message-ID: <20100526172824.GA9069__33434.4827490442$1274895016$gmane$org@elf.ucw.cz>
References: <AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
	<1274868384.5882.5169.camel@twins>
	<AANLkTimHGpRAZklIwXu6wEbA3coKXJvCVLxj2twerkCw@mail.gmail.com>
	<1274869262.5882.5222.camel@twins>
	<AANLkTik9LINPmabJfVi0jfVs5sjVS_1l00WpnVTFEuLV@mail.gmail.com>
	<1274890736.4467.574.camel@mulgrave.site>
	<1274891308.1674.1766.camel@laptop>
	<1274892847.4467.674.camel@mulgrave.site>
	<1274893228.1674.1772.camel@laptop>
	<1274894042.4467.727.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1274894042.4467.727.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Greg KH <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, Pekka Enberg <penberg@cs.helsinki.fi>, tytso@mit.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2010-05-26 12:14:02, James Bottomley wrote:
> On Wed, 2010-05-26 at 19:00 +0200, Peter Zijlstra wrote:
> > On Wed, 2010-05-26 at 11:54 -0500, James Bottomley wrote:
> > > Given that I'm in the latter category, I think suspend blockers is a
> > > reasonable solution to an existing problem.  I like Alan's idea of
> > > restricting the API into a single user space program so we contain the
> > > API contamination ... but realistically that's mostly the current
> > > suspend blockers anyway. 
> > 
> > There's a _large_ difference between resource limits and these wonky
> > suspend blockers.
> 
> Well, you have policy and then you have implementation ... suspend
> blockers just looks like an implementation to me.  It seems to be
> reasonably well suited in that regard ... after all, we kill processes
> that exhaust memory for instance or cut off write privileges to those
> that go over quota.  Preventing power hungry processes from consuming
> power by not allowing them to run until there's a wakeup event is fairly
> gentle by those standards.

Well, generic mechanism would stop processes when they run over
something -- not arbitrarily link it to device wakeup.

> > The main and most important one being that suspend is a global property
> > and can/will hurt sensible tasks. It puts the whole task model upside
> > down.
> 
> OK, so I believe you have an android phone ... it already implements
> this model ... specifically what are the problems on that platform this
> causes?

Besides that it is not linux system at all?

Yes, with custom userspace it works extremely nicely.

Had anyone even tried running oportunistic suspend on normal desktop?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
