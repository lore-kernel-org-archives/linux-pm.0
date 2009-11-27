From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Weird suspend/resume problem on HP nx6325 w/
	openSUSE 11.2 w/ -rc8
Date: Fri, 27 Nov 2009 02:04:15 +0100
Message-ID: <200911270204.15100.rjw__14734.544469002$1259283888$gmane$org@sisk.pl>
References: <200911220015.30912.rjw@sisk.pl>
	<21d7e9970911211955i69c12969n3085b6fc2c4a95f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <21d7e9970911211955i69c12969n3085b6fc2c4a95f9@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, DRI <dri-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 22 November 2009, Dave Airlie wrote:
> On Sun, Nov 22, 2009 at 9:15 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Hi,
> >
> > I'm not really sure where this should be reported, but here it goes.
> >
> > After installing openSUSE 11.2 on my testbed nx6325 I noticed that resume
> > (from suspend to RAM) stopped working on it.  Apparently, it hanged while
> > switching from the console back to X and the box remained completely
> > unresponsive after that (it didn't even react to the magic sysrq).  However,
> > it used to work just fine with -rc7 and openSUSE 11.1, so I figured the problem
> > was related to the new X driver, which is radeon module version 6.12.4 (xorg
> > server 1.6.5).
> >
> > So, I started to investigate and found that after a suspend from a framebuffer
> > console, the resume had always worked.  However, when I switched from X to the
> > framebuffer console, suspended, resumed and switched back to X, the box hanged
> > immediately just like during resume after a suspend from under X.  [There also
> > were some problems when switching from X to the framebuffer console and back
> > which seemd to be independent of suspend/resume (in short, the screen stays
> > black after a switch from the framebuffer console to X and you need to kill X
> > to fix this).]
> 
> You are using radeonfb on it? or vesafb?

vesafb

> first test is to try without either of those installed.

That doesn't change the behavior AFAICS.

> From memory though that machines an Xpress 200M

Yes, it has this one.

> which is the the worst graphics card for use with open drivers and has
> always caused no-end of pain.

Too bad. :-(

> Its also mostly undocumented when it comes to errata and workarounds.

Well, so I guess this is a hardware errata.

Still, it worked with the older X, so I wonder if I can make the new X work
like the old one?

Best,
Rafael
