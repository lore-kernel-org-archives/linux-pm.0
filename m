From: "David Singleton" <daviado@gmail.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 21 Aug 2006 22:20:02 -0700
Message-ID: <b324b5ad0608212220h1ef95d87w71a2ef6ded2ce7a5@mail.gmail.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
	<b324b5ad0608182310v348f8936j527357e60c3a77bb@mail.gmail.com>
	<20060822021305.GB22565@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060822021305.GB22565@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On 8/21/06, Greg KH <greg@kroah.com> wrote:
> On Fri, Aug 18, 2006 at 11:10:02PM -0700, David Singleton wrote:
> >                Oppoint could replace large pieces of the cpufreq code
> >        in the kernel, most notably the policy and governor code, which I
> >        believe belongs in user space in the power manager daemon.
> >
> >                You'll notice that the oppoint-cpufreq.patch only touches
> >        two files, cpufreq.c and cpufreq.h. It only creates two new
> >        interfaces
> >        to the cpufreq frequency scaling notifier lists to support drive=
r pre
> >        and post scaling routines, already supported in the kernel.
> >
> >                The oppoint-x86-centrino.patch completes the replacement
> >        of cpufreq code by introducing the transition routine to
> >        change frequencies and creates operating points for the
> >        centrino-speedstep processors already supported by Linux.
> >
> >        (although I've recieved a note from Intel that the data I've cop=
ied
> >        from the centrino-speedstep cpufreq tables is known to be inaccu=
rate
> >        and unsupported)
> >
> >                This code could replace cpufreq code and simplify it qui=
te a
> >        bit in the process.  The kernel drivers that support cpufreq
> >        frequency
> >        scaling would not have to be changed.  Operating points for the =
rest
> >        of the processors that support cpufreq would have to be created,=
 but
> >        as you can see it's quite a straight forward transformation from
> >        a cpufreq table to a set of operating points for a processor.
>
> This only touches on the cpu frequency stuff.  I am assuming that the
> current driver interface to the different power management states is
> acceptable to you?

   Yes.  The driver interface works perfectlly with the operating point des=
ign.
The power manager can simply set whatever operating point it wants the syst=
em
to be in and still have the flexibility to suspend individual devices throu=
gh
the current driver interface.  Drivers do not have be changed in any way
to operate correctly with the operating point model.

     The cpufreq driver scaling code doesn't need to changed either.  OpPoi=
nt
calls the same scaling routines throught the same notifier chain as
cpufreq does.

     That's two of the big advantages to the OpPoint design,
the driver interace doesn't need to change and the existing driver frequency
scaling code doesn't need to change either.

     Which makes sense since the operating point design is performing the s=
ame
functionality, just in a simpler manner.

      I still have to write a power manager for this so all the
policy/class stuff
that's being discussed now can be plug-ins for the power manager.  You'd
set you power management classes and policies up in the power manager,
wether its' performance, or energy efficiency, or thermal constraints,
or battery
constraints, and let it simply set operating states and handle
individual devices
as it sees fit.

      That's really where all the policy/class code belongs, in the
power manager.
OpPoint just provides a simpler interface for the power manager.  The opera=
ting
points are set by their name and the device control works just as it does t=
oday
through the sysfs interface.

David


>
> thanks,
>
> greg k-h
>
