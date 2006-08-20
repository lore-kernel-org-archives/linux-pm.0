From: "David Singleton" <daviado@gmail.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Sat, 19 Aug 2006 20:20:45 -0700
Message-ID: <b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060819184843.GB15644@redhat.com>
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
To: Dave Jones <davej@redhat.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On 8/19/06, Dave Jones <davej@redhat.com> wrote:
> On Fri, Aug 18, 2006 at 11:19:37PM -0700, David Singleton wrote:
>  > On 8/14/06, Greg KH <greg@kroah.com> wrote:
>  > > On Mon, Aug 14, 2006 at 07:48:01PM -0400, Dave Jones wrote:
>  > > >
>  > > > This adds a whole bunch of new code, and doesn't seem to make any
>  > > > existing code any simpler (to me at least).  From a cpufreq point =
of view,
>  > > > what does adding this buy us? What problem do we have today that is
>  > > > being solved by all this?
>  >
>  >
>  > Greg and Dave,
>  >
>  >       Here is the patch the provides the cpufreq functionality in an
>  > operating point
>  > fashion for the centrino-speedstep.   Cpufreq tables are transformed
>  > into operating
>  > points which can be simply set by writing the name of the operating
>  > point into /sys/power/state.
>  >
>  >      These two patches implement the cpufreq functionality of changing
>  > processsor
>  > frequency and voltage.  The huge amount of code that tries to make dec=
isions
>  > about what operating point to set and which devices can be suspended
>  > or not is left to
>  > the power manager.
>
> Why does this replicate the cpufreq driver instead of just *using* it ?
> From a distro vendor standpoint, I want to offer people choice, which mea=
ns
> with this patch we'd have both drivers compiled in, but this now means we
> have two sets of tables to add to every time we have new cpu support to a=
dd.
> Two places to look for implementation bugs etc etc.

        Dave,
                I didn't use the cpufreq driver because I couldn't.
        While encapsulated operating points can do CPU frequency
        scaling they also do a bit more.

                If you take a look at the 4th patch in the patch set,
        the oppoint-arm-pxa27x.patch, it shows that an operating point
        encapsulates a lot more system state than just the CPU.

                There are a set of clocks that have to managed and scaled
        when CPU frequency is scaled.  The arm-pxa27x patch also shows
        that this board has larger operating points but still uses
        the cpufreq driver scaling functions, with out any change
        to existing drivers.

                The operating point model performs the needed driver
        preparation and finishing routines to CPU and clock scaling
        by using the cpufreq driver scaling callbacks in the
        cpufreq notifier chain.

                The next three boards I'm working on have expanded
        system state encapsulated in their operating points. They
        have separately controllable power domains and they can
        run operating points at the same CPU frequency but at a lower
        voltage.  For example, one operating point runs at 168Mhz and 1.5V =
and
        another operating point runs at 168Mhz and 1.1V.

                While OpPoint can perform the same functionality as
        cpufreq, without the extra overhead and complexity of policies
        and governors, it provides a framework that can handle much
        more system state control, separate power domains, individually
        scalable clocks,  both frequency and voltage scaling and
        sleep states.

                The next three boards also have more than one sleep
        state.

                I like the cpufreq concept of defining the operating
        points at compile time and letting the system discover which
        CPU and operating points to install at boot time.   But I needed
        a bit more system state control than the cpufreq driver can
        provide.

                If I had all the existing cpufreq tables transformed
        into operating points I could make a patch that would remove
        the bulk of cpufreq code from the kernel and you'd have
        pretty much the same functionality without the maintenance
        issues the added layers and complexity bring.

                The aim of this patch set is to unify cpufreq with the Dyna=
mic
          Power Management infrastructure, which deals with complex
          system state and individual power domains, and clock domains, etc.
          If merged, there would just be one power management framework
          that all architectures and platforms could use.


David


>
>                 Dave
> --
> http://www.codemonkey.org.uk
>
