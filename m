From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Fri, 13 Jul 2007 14:01:34 +0200
Message-ID: <200707131401.35274.rjw__16142.9934124046$1184327672$gmane$org@sisk.pl>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707121953440.25614@asgard.lang.hm>
	<1184347974.4523.30.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1184347974.4523.30.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Friday, 13 July 2007 19:32, Huang, Ying wrote:
> On Thu, 2007-07-12 at 20:06 -0700, david@lang.hm wrote:
> > >> I agree, a stipped down hibernate kernel can be very small, not allocating
> > >> this memory until it's needed is a step for the final polishing.
> > >
> > > I'm not sure if I agree with that.  In any case, having to use two different
> > > kernels for hibernation would be a big drawback.
> > 
> > I see it as a big advantage to not have to use the main kernel for the 
> > suspend. please keep it as an option at least.
> 
> Yes. It has additional bonus to make it possible to write/read image
> from a program other than main kernel. For example, for a specific
> mobile device product (Such as Intel MID), a customized ultra-small
> program (or kernel) can be composed to write/read image. That way, the
> hibernate/resume time can be reduced to minimal.

You don't need kexec for that.  This is how the userland hibernation (aka
uswsusp) works.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
