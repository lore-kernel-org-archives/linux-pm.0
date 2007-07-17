From: jfannin@gmail.com (Joseph Fannin)
Subject: Re: Hibernating To Swap Considered Harmful
Date: Mon, 16 Jul 2007 20:12:39 -0400
Message-ID: <20070717001239.GB20082__26003.3034523532$1184631370$gmane$org@nineveh.local>
References: <200707121453.49616.rjw@sisk.pl>
	<Pine.LNX.4.64.0707121150460.25614@asgard.lang.hm>
	<200707122134.29991.rjw@sisk.pl>
	<Pine.LNX.4.64.0707121953440.25614@asgard.lang.hm>
	<20070713054244.GA20082@nineveh.local>
	<Pine.LNX.4.64.0707122250170.25614@asgard.lang.hm>
	<20070713062039.GA29055@nineveh.local>
	<Pine.LNX.4.64.0707122319270.25614@asgard.lang.hm>
	<20070713071512.GB29055@nineveh.local> <87odig1idx.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87odig1idx.fsf@jbms.ath.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Joseph Fannin <jfannin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 13, 2007 at 10:35:22AM -0400, Jeremy Maitin-Shepard wrote:
> jfannin@gmail.com (Joseph Fannin) writes:
>
> There is a very simple solution to this obscure problem: (if I
> understand correctly, you want to dual boot Mac OS X and Linux (and
> maybe also Windows?))
>
> use LVM, thus allowing you to have as many volumes as you like in the
> partition

Ok.

Why are all these workarounds preferred, instead of proper suspend
support for swap files?

IOW, what reasons are there to *not* support swap files, other than the
hit-and-miss Linux suspend support?

I brought up the swap file issue to illustrate that writing
hibernation images to files needs to be supported anyway.  Once you
have that, there is no good reason to write the hibernation image to
swap, and several reasons not to.

That my particular problem might be messily worked around isn't really
important in the context of that argument, which no one has responded
to.

(Aside from adding more administrivia to my Macintosh's setup, your
LVM suggestion would prevent the ext3 drivers for Windows and OS X
from working, as they don't do LVM.  This is arguably not Linux's
problem -- but Linux *already supports* a working solution).

--
Joseph Fannin
jfannin@gmail.com
