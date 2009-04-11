From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [REGRESSION] commit 66c1ca0: {fbmem: fix
	fb_info->lock and	mm->mmap_sem ...} causes Xfbdev not working
Date: Sat, 11 Apr 2009 21:32:26 +0200
Message-ID: <20090411193226.GA5440__26857.4053574868$1239478570$gmane$org@linux>
References: <f17812d70904090436kd03744brca4a4bc4b85bba8@mail.gmail.com>
	<20090409125850.GA2727@linux>
	<20090410222122.87be60f6.krzysztof.h1@poczta.fm>
	<20090410220521.GB21294@linux>
	<20090411080415.7fe924a2.krzysztof.h1@poczta.fm>
	<49E05C36.9040204@s5r6.in-berlin.de>
	<20090411110840.GA7108@linux> <20090411150359.GA8265@linux>
	<20090411112131.cc38dcf0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090411112131.cc38dcf0.akpm@linux-foundation.org>
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
Cc: Pavel Roskin <proski@gnu.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Andrey Borzenkov <arvidjaar@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 11, 2009 at 11:21:31AM -0700, Andrew Morton wrote:
> On Sat, 11 Apr 2009 17:04:00 +0200 Andrea Righi <righi.andrea@gmail.com> wrote:
> 
> > fbdev: fix info->lock deadlock in fbcon_event_notify()
> > 
> > fb_notifier_call_chain() is called with info->lock held, i.e. in
> > do_fb_ioctl() => FBIOPUT_VSCREENINFO => fb_set_var() and the some
> > notifier callbacks, like fbcon_event_notify(), try to re-acquire
> > info->lock again.
> > 
> > Remove the lock/unlock_fb_info() in all the framebuffer notifier
> > callbacks' and be sure to always call fb_notifier_call_chain() with
> > info->lock held.
> 
> Thanks.  So do you think we should proceed with this patch instead of
> reverting 66c1ca0?

Yes, there's no need to revert 66c1ca0 now, otherwise we'll simply
reintroduce the info->lock / mm->mmap_sem circular locking dependency.

I'd like to test the fbdev mode switching, but it seems intelfb doesn't
support it with LVDS ports (and at the moment I've not a CRT here...).

Anyway, if someone will have troubles with mode switching I'm quite sure
we can fix it on top of this patch.

-Andrea
