From: Dave Airlie <airlied@gmail.com>
Subject: Re: Weird suspend/resume problem on HP nx6325 w/
	openSUSE 11.2 w/ -rc8
Date: Sun, 22 Nov 2009 13:55:22 +1000
Message-ID: <21d7e9970911211955i69c12969n3085b6fc2c4a95f9__29426.3317985044$1258992641$gmane$org@mail.gmail.com>
References: <200911220015.30912.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911220015.30912.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, DRI <dri-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 22, 2009 at 9:15 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> I'm not really sure where this should be reported, but here it goes.
>
> After installing openSUSE 11.2 on my testbed nx6325 I noticed that resume
> (from suspend to RAM) stopped working on it. =A0Apparently, it hanged whi=
le
> switching from the console back to X and the box remained completely
> unresponsive after that (it didn't even react to the magic sysrq). =A0How=
ever,
> it used to work just fine with -rc7 and openSUSE 11.1, so I figured the p=
roblem
> was related to the new X driver, which is radeon module version 6.12.4 (x=
org
> server 1.6.5).
>
> So, I started to investigate and found that after a suspend from a frameb=
uffer
> console, the resume had always worked. =A0However, when I switched from X=
 to the
> framebuffer console, suspended, resumed and switched back to X, the box h=
anged
> immediately just like during resume after a suspend from under X. =A0[The=
re also
> were some problems when switching from X to the framebuffer console and b=
ack
> which seemd to be independent of suspend/resume (in short, the screen sta=
ys
> black after a switch from the framebuffer console to X and you need to ki=
ll X
> to fix this).]

You are using radeonfb on it? or vesafb?

first test is to try without either of those installed.

>From memory though that machines an Xpress 200M which is the the worst
graphics card for use with open drivers and has always caused no-end of pai=
n.

Its also mostly undocumented when it comes to errata and workarounds.

Dave.
