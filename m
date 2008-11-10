From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: Re: [Bugme-new] [Bug 11717] New: Pressing suspend button
	suspends, but does not wakes up
Date: Mon, 10 Nov 2008 12:15:50 -0200
Message-ID: <20081110141550.GB4450__3909.27667399428$1226327134$gmane$org@ime.usp.br>
References: <20081106194724.GB15366@ime.usp.br>
	<20081107014535.GA19201@ime.usp.br>
	<1226044855.4913f5b7f2f45@webmail.ime.usp.br>
	<20081108075008.GA8177@ime.usp.br>
	<dd18b0c30811080020i23418742xc6388a5942456566@mail.gmail.com>
	<20081109024514.GA11744@ime.usp.br>
	<20081109113332.GD6094@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081109113332.GD6094@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Justin Mattock <justinmattock@gmail.com>, linux-kernel@vger.kernel.org, yakui.zhao@intel.com, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@lists.linux-foundation.org, acpi-bugzilla@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi, Pavel.

On Nov 09 2008, Pavel Machek wrote:
> On Sun 2008-11-09 00:45:14, Rog=E9rio Brito wrote:
> > On Nov 08 2008, Justin Mattock wrote:
> > > On Fri, Nov 7, 2008 at 11:50 PM, Rog=E9rio Brito <rbrito@ime.usp.br> =
wrote:
> > > > I think that I have some more information regarding the
> > > > suspend/hibernate issue: with Ubuntu's 2.6.27 kernel, I can't
> > > > hibernate my laptop, but with vanilla 2.6.28-rc3, I can hibernate
> > > > (I have not tested it much, but it seems to work).

I spoke too soon. Depending on what I do in userland (I tried using the
GNOME application "Cheese" just to put some load on the machine) and I
tried:

# echo shutdown > /sys/power/disk
# echo disk > /sys/power/state

But the machine stuck: it blanked the monitor, seemed to go to a console,
the cursor was blinking on the upper left corner of the screen, the HD
light blinked once and then the fan went faster, the CPU hotter and the
leds corresponding to caps lock and scroll lock were blinking.

I'm waiting with the machine in this situation since I started composing
this e-mail and nothing has changed.

The blinking leds (caps and scroll lock) would indicate a kernel panic, is
that correct?

> Try it from the text console, and see what exactly stops
> responding. "killall klogd" is your friend.

The funny thing is that once that I could resume, it resumed
instantly. :-( Weird.


Thanks, Rog=E9rio Brito.

-- =

Rog=E9rio Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
