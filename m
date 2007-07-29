From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH 2/2] Introduce CONFIG_SUSPEND
Date: Sun, 29 Jul 2007 22:30:40 +0100
Message-ID: <1185744640.2295.4.camel__33995.515612378$1185745003$gmane$org@work>
References: <200707251238.50218.lenb@kernel.org>
	<200707292317.21419.rjw@sisk.pl> <20070729211824.GL16817@stusta.de>
	<200707292336.55588.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707292336.55588.rjw@sisk.pl>
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
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-07-29 at 23:36 +0200, Rafael J. Wysocki wrote:
> On Sunday, 29 July 2007 23:18, Adrian Bunk wrote:
> > On Sun, Jul 29, 2007 at 11:17:20PM +0200, Rafael J. Wysocki wrote:
> > > On Sunday, 29 July 2007 22:40, Adrian Bunk wrote:
> > > > On Sun, Jul 29, 2007 at 02:38:05PM +0200, Rafael J. Wysocki wrote:
> > > > >...
> > > > > +config SUSPEND
> > > > > +	bool "Suspend"
> > > >              "Suspend to RAM"
> > > 
> > > Not only.  This also includes "standby".
> > 
> > Whatever it includes - please tell it to the user in the prompt.
> > 
> > Technical issues are important, but it's often forgotten how many 
> > problems people run into because the description of a kconfig option 
> > could have been better.
> 
> Sure.  Please see the updated patch I've just sent. :-)

So are you guys using:

"standby" = idle state, ~0.5 seconds
"suspend" = sleep to ram, ~10 seconds
"hibernate" = sleep to disk, ~30 seconds

If so - you rock. This is the common nomenclature I've been pushing for
a few months now in GNOME, KDE and general userspace. I've written up a
spec here:
http://cvs.gnome.org/viewcvs/*checkout*/gnome-power-manager/docs/sleep-names.html

Richard.
