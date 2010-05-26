From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Thu, 27 May 2010 00:13:21 +0200
Message-ID: <201005270013.21412.rjw__23619.7006110617$1274916761$gmane$org@sisk.pl>
References: <1274863342.5882.4850.camel@twins>
	<20100526165919.GB2089@elf.ucw.cz>
	<1274893309.1674.1773.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274893309.1674.1773.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Greg KH <gregkh@suse.de>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, James Bottomley <James.Bottomley@suse.de>, tytso@mit.edu, Pekka Enberg <penberg@cs.helsinki.fi>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 May 2010, Peter Zijlstra wrote:
> On Wed, 2010-05-26 at 18:59 +0200, Pavel Machek wrote:
> > On Wed 2010-05-26 18:28:28, Peter Zijlstra wrote:
> > > On Wed, 2010-05-26 at 11:18 -0500, James Bottomley wrote:
> > > > > Or make the suspend manager a C proglet and provide a JNI interface,
> > > > > or whatever.
> > > > 
> > > > It's a fairly large piece of code to try to rewrite in C, so I don't
> > > > think that's feasible on a reasonable timescale.  Android does have the
> > > > concept of special sockets that can be used to communicate from less to
> > > > more privileged processes (it has a very segmented runtime model), so
> > > > these might be usable ... they have a drawback that they're essentially
> > > > named pipes, so no multiplexing, but one per suspend influencing C
> > > > process shouldn't be a huge burden. 
> > > 
> > > It wouldn't need to convert the whole Frameworks layer into C, just
> > > enough to manage the suspend state.
> > > 
> > > Anyway, I think there's been enough arguments against even the concept
> > > of opportunistic/auto-suspend, and I for one will object with a NAK if
> > > Rafael send this to Linus.
> > 
> > It was submitted already. I tried to followup with NAK, but can't
> > currently see it in the archive.
> 
> It was apparently hidden on some funky list. Hiding pull requests is bad
> enough, but hiding pull requests for contended features is just plain
> wrong.

It was not intentionally hidden.  I think my mailer did that wrong because
the CC list was too long or something like this.  I surely intended to send
it to the LKML, so sorry for the inconvenience.

Rafael
