From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: SMP suspend broken due to "swsusp: Change code
	ordering in disk.c" et al.
Date: Sat, 24 Feb 2007 09:57:21 +0100
Message-ID: <200702240957.22636.rjw@sisk.pl>
References: <1172201385.15769.32.camel@johannes.berg>
	<200702240101.12846.rjw@sisk.pl>
	<1172277080.3870.108.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1172277080.3870.108.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Dave Vasilevsky <djvasi@gmail.com>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 24 February 2007 01:31, Johannes Berg wrote:
> Hi,
> =

> > Could you please try the appended patch?  It's somewhat hackish, but ma=
y work.
> =

> Not before Monday or Tuesday unfortunately, I'm away from the machine.

Okay, no big deal.  I think I'll be able to reproduce the problem here. ;-)

> Maybe I can find someone else willing to test who has the same box.
> =

> > The idea is to do nothing on CPU unplug if the CPU's worker thread is f=
rozen
> > and later check in the thread itself if it has been replaced by another=
 one.
> =

> Yeah that should work. That patch won't apply to my tree though unless I
> actually go to -mm2 as well :)

Ah, sorry.  I'll prepare a version against 2.6.21-rc1.  Apart from this, I
think there's a better solution, but I have to verify that.

Greetings,
Rafael
