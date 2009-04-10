From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken and
	(minor but annoying) audio problem
Date: Fri, 10 Apr 2009 20:58:35 +0200
Message-ID: <200904102058.36018.rjw__39729.3553025976$1239390211$gmane$org@sisk.pl>
References: <200904100057.43827.rjw@sisk.pl>
	<alpine.LFD.2.00.0904091605080.4583@localhost.localdomain>
	<200904101439.43480.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904101439.43480.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Friday 10 April 2009, Rafael J. Wysocki wrote:
> On Friday 10 April 2009, Linus Torvalds wrote:
> > 
> > On Fri, 10 Apr 2009, Rafael J. Wysocki wrote:
> > > 
> > > I'm seeing two problems with -git from today.
> > 
> > When today? A number of people apparently had module problems before 
> > commit 97c18e2c7a8e36d2d83d50ee070314aadac73a11 ("module: 
> > try_then_request_module must wait").
> > 
> > If you don't have that one, then that might explain both problems, in that 
> > a "second try" would work for modules (your sound issue), and that 
> > compiling things in would obviously avoid it (your storage driver thing).
> > 
> > But if you _do_ have that, then it's obviously something else ;)
> 
> Well, I do have that one. :-)

I've just verified that the resume-after-hibernation issue goes away after
reverting commit 9710794383ee5008d67f1a6613a4717bf6de47bc
(async: remove the temporary (2.6.29) "async is off by default" code) , so it
is async-related.

The audio issue still remains after the revert, so it is really different.

Thanks,
Rafael
