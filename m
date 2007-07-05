From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: The big suspend mess
Date: Thu, 5 Jul 2007 14:18:29 +0200
Message-ID: <200707051418.30138.rjw__37576.2285352268$1183637512$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<20070705002747.GA2952@elf.ucw.cz>
	<20070705012206.GN3492@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070705012206.GN3492@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 03:22, Adrian Bunk wrote:
> On Thu, Jul 05, 2007 at 02:27:47AM +0200, Pavel Machek wrote:
> > 
> > > IMHO the suspend code is currently way too much of a moving target which 
> > > results in this mess.
> > > 
> > > The correct order seems to be:
> > 
> > 0. Get someone to sign up as a maintainer for suspend, so we have
> > someone to blame for the mess? :-)
> 
> The "SOFTWARE SUSPEND" entry in MAINTAINERS already contains a victim...  ;-)
> 
> My impression is that suspend is an area of the kernel that does not 
> lack maintainers - you and Rafael are doing a good job, and there's e.g. 
> also the maintained code formerly known as suspend2.
> 
> But some basic questions like e.g.
> - What should be done in the kernel and what in userspace?
> - How should this be implemented?
> - What must subsystems and drivers do?
> - What must subsystems and drivers not do?
> seem to be in a constant flux because the big picture everyone agrees 
> upon seems to be missing.

Well, to some extent I agree, but that's because it's difficult to reach such
an agreement and if we have one, new poeple come with new ideas and we need to
start all over again. :-)

In the meantime, problems are reported that need to be fixed and the fixes
often break other systems and we learn about that too late ect.

As far as the big picture is concerned, we have already agreed, or at least
this is my impression, that we need to separate the drivers' suspend callbacks
(as they exist today) from their hibernation callbacks (not present yet).

This seems to be needed for a couple of reasons, the first of them being that
the desired functionality of the hibernation code may be substantially
different from the desired functionality of the suspend code.  For instance,
it generally is not necessary to put devices into low power states, or to power
them off, in order to create the hibernation image, while it is necessary to do
that for a suspend.

It will require us to redesign the core quite a bit and I've already started to
prepare for that.  I really would like to do that in the first place and _then_
to think of improving both the suspend and hibernation code paths
_separately_.  This way, we can do things more easily and in a much more clean
way.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
