From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 13:09:48 -0500
Message-ID: <1274897388.4467.888.camel__49305.5980805822$1274897447$gmane$org@mulgrave.site>
References: <AANLkTimHGpRAZklIwXu6wEbA3coKXJvCVLxj2twerkCw@mail.gmail.com>
	<1274869262.5882.5222.camel@twins>
	<AANLkTik9LINPmabJfVi0jfVs5sjVS_1l00WpnVTFEuLV@mail.gmail.com>
	<1274890736.4467.574.camel@mulgrave.site>
	<1274891308.1674.1766.camel@laptop>
	<1274892847.4467.674.camel@mulgrave.site>
	<1274893228.1674.1772.camel@laptop>
	<1274894042.4467.727.camel@mulgrave.site>
	<1274894602.1674.1780.camel@laptop>
	<1274895188.4467.783.camel@mulgrave.site>
	<20100526174258.GF9069@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526174258.GF9069@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, Pekka Enberg <penberg@cs.helsinki.fi>, tytso@mit.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-05-26 at 19:42 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > The main and most important one being that suspend is a global property
> > > > > and can/will hurt sensible tasks. It puts the whole task model upside
> > > > > down.
> > > > 
> > > > OK, so I believe you have an android phone ... it already implements
> > > > this model ... specifically what are the problems on that platform this
> > > > causes?
> > > 
> > > I do not have one, nor have I ever written an application for it (nor
> > > will I likely ever do that, since I detest Java), but I would expect an
> > > application to run when its runnable.
> > 
> > OK, so I've got one ... tell me what I should see and I'll try to
> > reproduce.
> 
> Umm... try to boot ordinary distro and see how it copes with
> opportunistic suspend?

That's not really going to help, is it?  The issue I was curious are
what are the bad things that result from interfering with the regular
scheduling of processes ... because undeniably suspend (whether
opportunistic or ordinary) does produce this interference.

I could boot debian on an android and have it suspend ... that's still
not going to answer my question.

> I do have android here, and of course it work well with custom
> userland. Question is: can common distro be reasonably modified to
> work with suspend blockers, in a way that's backward compatible?

You mean how an app could run if it was compiled with suspend blockers
but the platform doesn't support it?  That's a simple runtime switch in
the library surely?

James
