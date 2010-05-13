From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 10:33:10 -0700
Message-ID: <1273771990.19100.13.camel__38450.1107539565$1273772073$gmane$org@c-dwalke-linux.qualcomm.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<20100513121745.GA10749@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513121745.GA10749@srcf.ucam.org>
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
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@ericsson.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-05-13 at 13:17 +0100, Matthew Garrett wrote:
> On Wed, May 12, 2010 at 09:35:30PM -0600, Paul Walmsley wrote:
> > 
> > Figuring out a different way to do this should not limit Android at all, 
> > since Google can do what other Linux distributions do and continue to 
> > patch opportunistic suspend/suspend-block calls into their kernels as 
> > needed to ship devices, while contributing towards a different solution to 
> > the problem.
> 
> I basically agree, except that despite having a year to do so none of us 
> have come up with a different way that would actually work. Google have 
> done this work. Who's going to prove that there is actually a different 
> way to do this?

We all feel the pain of inelegance right? I think it's clear that this
system will not last (but there's no other immediate option) .. That
doesn't mean we should reject it, but we need to be clear that this
system will get replaced. So we should format the patches appropriately.
To me the userspace aspect is a permanent change .. If we could drop
that (or put it into debugfs) then it would make this a lot easy to
accept as a stepping stone.

Daniel
