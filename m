From: Mark Gross <mgross@linux.intel.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 23 Aug 2006 12:05:09 -0700
Message-ID: <20060823190509.GB22525@linux.intel.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<b324b5ad0608182310v348f8936j527357e60c3a77bb@mail.gmail.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <b324b5ad0608182310v348f8936j527357e60c3a77bb@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 18, 2006 at 11:10:02PM -0700, David Singleton wrote:
> On 8/14/06, Greg KH <greg@kroah.com> wrote:
> >On Mon, Aug 14, 2006 at 07:48:01PM -0400, Dave Jones wrote:
> >>
> >> This adds a whole bunch of new code, and doesn't seem to make any
> >> existing code any simpler (to me at least).  From a cpufreq point of =

> >view,
> >> what does adding this buy us? What problem do we have today that is
> >> being solved by all this?
> =

> Greg and Dave,
> =

>                 there are two competing patch sets for a new power =

>                 management
>        framework.   The patch set I sent out simplifies power management,
>        from both the cpufreq perspective and the embedded world's view of
>        power management.

Why can't we have one evolve a single powerOP framework?  Both of these
patches are derived from The MV/Todd Poynor's patches.  It seems "funny"
to not coordinate these two patch sets.

> =

>                I've renamed my patch oppoint so as not confuse it
>        with the powerop set from Matt Locke (which will probably make
>        it even more confusing).  I've renamed it so it can be seen as an
>        alternative design approach, not just an alternative implementation
>        of the same ideas.  I've also incorporated suggestions from
>        Pavel in cleaning up the original patches.
> =

>                If you'd be willing to take a look at, or try out, the =

>                patches
>        in my patch set you should be able to see how oppoint could simpli=
fy
>        cpufreq code.  The first patch is the oppoint-cpufreq.patch and
>        the second is the oppoint-x86-centrino.patch.

How would the ACPI cpufreq_driver be integrated with this design?

> =

>                Oppoint could replace large pieces of the cpufreq code
>        in the kernel, most notably the policy and governor code, which I
>        believe belongs in user space in the power manager daemon.

How will the users of on-demand make use of this design?
I don't think you can just dump the governor function of CPUFREQ for
user defined performance control.

> =

>                You'll notice that the oppoint-cpufreq.patch only touches
>        two files, cpufreq.c and cpufreq.h. It only creates two new =

>        interfaces
>        to the cpufreq frequency scaling notifier lists to support driver =
pre
>        and post scaling routines, already supported in the kernel.

re-using the cpufreq notification infrastructure makes sense.

>                The oppoint-x86-centrino.patch completes the replacement
>        of cpufreq code by introducing the transition routine to
>        change frequencies and creates operating points for the
>        centrino-speedstep processors already supported by Linux.
> =

>        (although I've recieved a note from Intel that the data I've copied
>        from the centrino-speedstep cpufreq tables is known to be inaccura=
te
>        and unsupported)
> =

>                This code could replace cpufreq code and simplify it quite=
 a
>        bit in the process.  The kernel drivers that support cpufreq =

>        frequency

Only for user mode governors, I believe kernel mode governors still have
role in Linux.



--mgross

>        scaling would not have to be changed.  Operating points for the re=
st
>        of the processors that support cpufreq would have to be created, b=
ut
>        as you can see it's quite a straight forward transformation from
>        a cpufreq table to a set of operating points for a processor.
> =

>                The entire patch set can be found at:
> =

>                http://source.mvista.com/~dsingleton/2.6.18-rc4/
> =

>        The patch set consists of:
> =

>                oppoint-core.patch
>                oppoint-cpufreq.patch
>                oppoint-x86-centrino.patch
>                oppoint-arm-pxa27x.patch
> =

>        I'll attach oppoint-cpufreq.patch  to this email and
>        send out oppoint-x86-centrino.patch next.
> =

> =

> David
> =

> =

> =

> >>
> >> Every explanation of powerop I've seen so far dives into microdetails,
> >> whilst the 10,000ft view has always passed me by other than "this is
> >> what we've had in the embedded world".
> >>
> >> The diagram at =

> >http://lists.osdl.org/pipermail/linux-pm/2006-August/003196.html
> >> also confuses me.  I was under the impression that powerop was adding =

> >additional
> >> userspace interfaces.  If we're not changing how things from a userspa=
ce
> >> point of view, we're churning a lot of kernel code,.. why?
> >>
> >> Clue me in here, I'm feeling thick.
> >
> >You're not alone, I really don't get it either.
> >
> >But I guess we'll just wait for the next round of unified patches and
> >then go from there.
> >
> >thanks,
> >
> >greg k-h
> >_______________________________________________
> >linux-pm mailing list
> >linux-pm@lists.osdl.org
> >https://lists.osdl.org/mailman/listinfo/linux-pm
> >


> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
