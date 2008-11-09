From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: Re: [Bugme-new] [Bug 11717] New: Pressing suspend button
	suspends, but does not wakes up
Date: Sun, 9 Nov 2008 00:45:14 -0200
Message-ID: <20081109024514.GA11744__12836.9869235486$1226198895$gmane$org@ime.usp.br>
References: <20081106194724.GB15366@ime.usp.br>
	<20081107014535.GA19201@ime.usp.br>
	<1226044855.4913f5b7f2f45@webmail.ime.usp.br>
	<20081108075008.GA8177@ime.usp.br>
	<dd18b0c30811080020i23418742xc6388a5942456566@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <dd18b0c30811080020i23418742xc6388a5942456566@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: rbrito@ime.usp.br, linux-kernel@vger.kernel.org, yakui.zhao@intel.com, pavel@suse.cz, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi, Justin and others.

On Nov 08 2008, Justin Mattock wrote:
> On Fri, Nov 7, 2008 at 11:50 PM, Rog=E9rio Brito <rbrito@ime.usp.br> wrot=
e:
> > I think that I have some more information regarding the suspend/hiberna=
te
> > issue: with Ubuntu's 2.6.27 kernel, I can't hibernate my laptop, but wi=
th
> > vanilla 2.6.28-rc3, I can hibernate (I have not tested it much, but it
> > seems to work).

Just some extra information here: while I can hibernate with vanilla
2.6.28-rc3, upon resuming, it takes *minutes* (I don't know how many
minutes, but probably something like 5 minutes or so!) for the desktop to
have any effect (despite the fact that I can move the mouse without any
problems).

A new reboot is *much* faster than what I get with hibernate.

I can film that if desired.

> > But seeing the behaviour of this in comparison with Windows Vista, two
> > things still stand out:
> >
> > 1 - pressing the suspend button suspends the machine, but upon a second
> >    press, the machine still turns itself off and all work is lost. :-(

This problem still persists.

> > 2 - closing the lid, no matter what I program in GNOME's Power Preferen=
ces,
> >    doesn't even blackens the screen, let alone suspend or hibernate the
> >    notebook.

A correction here: when I close the lid, the laptop suspends. I can try to
see if it hibernates.

> > Again, for those that I just included in the carbon copies now, I have
> > given extensive information on the bugzilla report, but I can recompile
> > kernels, get dumps of debugging information, get dumps under Windows (if
> > that helps and if I am instructed how to do that). You name it. I am re=
ally
> > willing to help as much as possible with all efforts that are possible =
to
> > me.

Again, I am willing to get any debugging information or anything that is
asked me. I am testing things and I still don't have any production data on
that notebook.

BTW, I installed Windows Vista with a dual boot. I'm feeling tainted
now. :-(

> I think you might be experiencing the dreaded black screen upon
> wakeup.(after seeing you're quick video);

Nice that the video proved useful to demonstrate the issue. I can take
another video to show the current behaviour with 2.6.28-rc3.

> I was having the same with my macbook pro, when running
> radeonhd(haven't tried s2ram yet to see if this resolves the issue).
> Although was told it should fix the issue.

Right. Just for further information, this notebook here has a plain ICH8
chipset. The only thing that I think that is not from intel is the gigabit
ethernet, which is a Realtek one (it seems that the r8169 driver is loaded,
but I still have not tested wired connections).

> Did have the same(black screen of death wakeup); with a dell
> inspiron, but then realized my graphics modules weren't configured
> properly.

Weird. I have a Dell Latitude D520 here (which I'm using for this e-mail)
and everything that I tried works fine (suspend, wifi, hibernation and even
the compiz stuff---which I promptly disable). It has a broadcom ethernet
that seems to use the b44 driver, but I have also not used the wired
connection here.

I'm streaming audio via daap to this notebook from a Kurobox (powerpc box)
with kernel 2.6.27 kernel (and my patches that were included in
2.6.28-rc3).

> As for the pressing of buttons, the initial pressing of the power button =
send's
> shutdown to the machine for me, but when suspending the system, the power=
 button
> wakes the machine up, or closing and opening the lid.

For me, nothing like this works. :-( I can open the lid and it still stays
sleeping. Pressing the suspend (poweron/poweroff?) button while suspended
only turns off the machine. :-(


Thanks again for any feedback, Rog=E9rio Brito.

-- =

Rog=E9rio Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
