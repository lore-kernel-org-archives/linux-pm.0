From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 10:50:20 +1000
Message-ID: <200606071050.24916.ncunningham@linuxmail.org>
References: <4480C102.3060400@goop.org> <200606071005.14307.ncunningham@linuxmail.org> <20060607004217.GF11696@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart20171759.IrOMuyQhyY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751136AbWFGAtU@vger.kernel.org>
In-Reply-To: <20060607004217.GF11696@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>, Linux-pm list <linux-pm@lists.osdl.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, shaohua.li@intel.com, miles.lane@gmail.com, jeremy@goop.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--nextPart20171759.IrOMuyQhyY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 07 June 2006 10:42, Don Zickus wrote:
> On Wed, Jun 07, 2006 at 10:05:07AM +1000, Nigel Cunningham wrote:
> > Hi.
> >
> > On Wednesday 07 June 2006 09:55, Don Zickus wrote:
> > > > > So my question is/was what is the proper way to handle processor
> > > > > level subsystems during the suspend/resume path on an SMP system.=
=20
> > > > > I really don't understand the hotplug path nor the suspend/resume
> > > > > path very well.
> > > >
> > > > Make it work properly for CPU hotplug for individual CPU and then in
> > > > suspend you take care of "global" state and the last CPU.
> > >
> > > So the assumption is treat all the cpus the same either all on or all
> > > off, no mixed mode (some cpus on, some cpus off).  I guess I was tryi=
ng
> > > to hard to work on the per-cpu level.
> >
> > This sounds wrong to me. Shouldn't the the effect of hotunplugging a cpu
> > be to put the driver in a state equivalent to if that cpu simply didn't
> > exist? Unplugging shouldn't assume we're going to subsequently have
> > either a driver suspend, or a replug.
>
> This is my biggest problem or maybe my complete lack of understanding, is
> that I don't know how to determine what state I am in during a hotplug
> event, either a cpu removal or a suspend.  Therefore I feel like I have to
> store some persistant data around _just_ in case this is a suspend event.
> Also at the opposite end, how to separate a cpu insert vs. a cpu resume.
> The different being initialize to a global state vs. initialize to a last
> known state.
>
> I thought it would make more sense if a few more states were to the
> hotplug event list.  For example, in addition to CPU_ONLINE and CPU_DEAD,
> there could also be something like CPU_SUSPEND, CPU_FREEZE, CPU_RESUME,
> and CPU_THAW.
>
> Anyway, I am probably complicating the matter.  I'll whip something up and
> post it for review.

Act like...

Unplug: It's going away, never to return.
Plug: It's just appeared from nowhere, is completely uninitialised and may =
be=20
a different item to anything that happened to look the same before.
Suspend: It's going to be put into a low (possibly no-) power state. It's=20
going to come back, and when it does, you want to be able to put it back in=
=20
the state it's in prior to this call.
Resume: You want to restore the state you saved in memory when given the=20
suspend call earlier.

Regarding _FREEZE, there is work in progress to add this. I haven't been=20
following the conversation really closely recently, but my understanding is=
=20
that you should expect it to be similar to suspend, except that you can=20
guarantee that power will not be lost. All activity should be stopped so th=
at=20
you get a consistent state which you can restore in the resume call. Every=
=20
suspend or freeze must be followed by a resume.

I'll add the linux-pm list to the cc, just in case I've gotten something wr=
ong=20
or the other guys want to comment and have missed this thread.

Hope this helps.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart20171759.IrOMuyQhyY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEhiLQN0y+n1M3mo0RAoxOAKCsZftYPolOI3tQBnHR7OwnSC9chACdHntY
GXWmOGPKbE4gjw+uBdQ3u3M=
=N4Gf
-----END PGP SIGNATURE-----

--nextPart20171759.IrOMuyQhyY--
