From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS
	framework	with device-specific OPPs
Date: Wed, 27 Apr 2011 14:36:37 +0100
Message-ID: <20110427133637.GA25850@sirena.org.uk>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<20110426132224.GC13597@suse.de>
	<BANLkTi=VFPZinH+1x0xBTP9o_s6+2gsA7w@mail.gmail.com>
	<20110426205430.GA20381@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110426205430.GA20381@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 26, 2011 at 01:54:30PM -0700, Greg KH wrote:
> On Tue, Apr 26, 2011 at 10:45:18PM +0800, Jiejing.Zhang  wrote:

> > I think DVFS here means ???Dynamic voltage and frequency scaling???,?? refering the
> > first google's result:

> Ok, if so, please spell it out.

> Also, don't use 'dvfs' as a prefix in the kernel, too many other people
> will think it is a filesystem.  How about "dynvolt"?

> Or anything else, just no 'fs' in the name otherwise confusion will
> reign.

This really is the standard technical term for this, it's vanishingly
rare for it to be a source of confusion in context.  We should at least
mention the actual term in the documentation even if we invent our own
name for it.
