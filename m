From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 24 Aug 2006 09:52:33 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50745C3AF@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> > > ...which is very bad interface for applications. See my other
> > > mail. Applications should not have to play with fast/medium/slow,
> > > explicitely. Instead, on opening /dev/dsp, you should power up the
> > > sound system (and maybe adjust cpu frequency if
> > > neccessary). Application should not have to do echo fast >
somewhere
> > > before opening /dev/dsp
> >
> > How does /dev/dsp know at what level it can run at?  On the SOC I
> > control the speed of the DSP.  I can adjust its MIPs rate.
> =

> (I meant /dev/dsp -- OSS audio device, not Digital Signal Processor).

It can be all the same.

The device behind /dev/dsp doing the work likely is the main control
processor or it is a DSP (and some side mixer chip or not).  The DSP in
the laptop case might be hidden inside some PCI composite device and
present its own interface.  Thus you may treat it as some discrete
device with one register range.  On the SOC it is all unrolled and you
must control all the pieces individually (and in concert with each
other).  The DSP in both cases may have its own OS also running.  This
is generally what you download as firmware.

When I want to frequency and/or voltage scale I must take into account
what the DSP is doing and what the applications processor is doing.
This is not so different from today's SMP/Core-Duo type systems where
both CPUs are in the same voltage plane.  You can't change one with out
affecting the other.

The internal busses in SOCs wrap all these integrated peripherals in a
common way and add power hooks.  This allows them to achieve massive
power optimizations which are not likely possible in the PC world.

> > A missing pieces is meaningful coordination between devices.  Each
> > device is not an island.  Not taking care of all devices on the
internal
> > interconnects may mean you don't get the big power savings.  For the
DSP
> =

> For notebooks, devices *are* islands. powerop tries to push
> everything-depends-on-everything model that may be good for some SoC,
> but sucks for notebooks. We need some middle ground.

USB being enabled and causing your laptop battery to dry up is a case
where laptop device dependency has been shown.  There are likely many
more cases.  I would expect BIOS/chip set developers are all too aware
of these in their sub-domains.

On a PC it might be hardware bugs and software bugs which are cause some
of the problems.  This is the case for embedded also.  An embedded SOC
does have another dimension in that they are designed to have global
system power states which include all devices (a processor is just
another device and their may be many).  Their high level of integration
enables this.  Linux's device model doesn't match up well with this.
There are X standard ways in which it is done by various vendors.
PowerOP at the low level provides a mechanism to abstract these
differences.

Thanks,
Richard W.
