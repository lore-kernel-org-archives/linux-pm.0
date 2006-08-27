From: "David Singleton" <daviado@gmail.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Sat, 26 Aug 2006 21:37:14 -0700
Message-ID: <b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
	<b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
	<20060820033044.GA24928@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060820033044.GA24928@redhat.com>
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
> On Sat, Aug 19, 2006 at 08:20:45PM -0700, David Singleton wrote:
>
>  > If I had all the existing cpufreq tables transformed
>  > into operating points I could make a patch that would remove
>  > the bulk of cpufreq code from the kernel and you'd have
>  > pretty much the same functionality without the maintenance
>  > issues the added layers and complexity bring.
>
> If this is going to fly at all, I think thats where we need to be headed.
> Having two parts of the kernel doing the same thing just seems
> very wrong to me.
>
> The other alternative as suggested earlier this week would be archictures
> getting to 'opt out' of powerop for their cpufreq drivers where it doesn't
> necessarily bring anything but the layer of indirection.
>
> I'm about to disappear for two weeks for a much needed vacation, but
> I'll be interested to see other folks comments/opinions on this
> when I get back.

        This week I got some really good feedback and suggestions
        from Mark Gross on the kernel interface and usability and
        I have two new additions for this patch set.  So I spend the week
        working on a well thought out kernel interface.

        1) I believe I now have the right kernel interface for a common
        power management infrastructure.

        The new kernel interface still uses /sys/power/state to both
        show the current operating point and set a desired operating
        point, by name. There is a new /sys/power/operating_points directory
        that shows all the operating points the system supports. An
        exampled from my centrino laptop shows:

        /sys/power/operating_points/high
        /sys/power/operating_points/highest
        /sys/power/operating_points/low
        /sys/power/operating_points/lowest
        /sys/power/operating_points/medium
        /sys/power/operating_points/mem
        /sys/power/operating_points/standby

        In each operating point directory there are three files,
        frequency, voltage and latency.  They show the frequency,
        voltage and transition latency respectively for the operating
        point. An example from my centrino laptop shows:

        /sys/power/operating_points/high/frequency
        /sys/power/operating_points/high/voltage
        /sys/power/operating_points/high/latency

        I've finally had a bit of time to get the sysfs one file - one
        value system in place for OpPoint.

        2) The really good news is there is a now a power manager for
OpPoint now,
        both in rpm and src rpm form.  And since the new power manager runs=
 off
        the new kernel interface and actually does what the cpuspeed daemon=
 does
        I think the kernel interface is sound.

        I took the cpuspeed power manager daemon, version 1.2.1, and modifi=
ed
        it Friday to use the oppoint interface. It supports all the
        options the cpuspeed daemon does, (and can actually still be compil=
ed to
        be the original cpuspeed daemon) it just uses the interface
        described above instead of the cpufreq interfaces.

        For anyone out there with a centrino laptop there is now
        a complete solution for oppoint power management.  To try
        the solution you'll only have to add three patches to the
        2.6.18-rc4 kernel and install the oppointd rpm.

        The patches you'll need are:

                oppoint-core.patch
                oppoint-cpufreq.patch
                oppoint-x86-centrino.patch

        The oppointd rpm installs these files on your system:

                /etc/sysconfig/oppoint-powermanagement
                /etc/init.d/oppointd
                /usr/sbin/oppointd
                /usr/local/man/man.1/oppointd


        "/etc/init.d/oppoint start"  turns on the daemon and off it
        goes.  The default configuration uses the system load as
        an indicator or operating point to run.  The more idle the
        system is the lower the operating point.  When the system
        is unused it quickly drops to the lowest operating point.
        It's the power management policy I like to use for my laptop.

        Within 2 seconds the system drops into the lowest state if
        the machine is comletely idle, and up to the highest state
        within two seconds when I start off a kernel build.

        The default configuration also uses the acpi AC adapter state.
        When the AC adapter is not plugged the system goes into the low
        state.

        I have a patch for the AMD elan processor line and the
powernow-k6 processors,
        but I don't have any hardware to test them on.  If anyone
        would be willing to help me test the elan, powernow-k6 (and
        soon the powernow-k7) patches I'd really appreciate it.

        The patchset and rpmsl are available at:

        http://source.mvista.com/~dsingleton

        There is one last thing I'd like to point out.  This interface
        can support all the thousands of power management policy combinatio=
ns
        being discussed. It can support each operating state the system can
        support and all the combinations of each state and a set
        of devices on the system being suspended or not.  And none of
        the power management policies need to be in the kernel to
        be supported.

        For example, this interface will support a power management policy =
so
        the system can run at the medium state to run an mp3 player and
        suspend the lcd and usb controller, or leave the usb controller
        on if its being used.

        The thousands of combinations of possible power management
        policies belong in the power manager, which can be much more easily
        tailored to the individual platfrom, whether server, laptop or hand=
held.

David

>
>                 Dave
>
> --
> http://www.codemonkey.org.uk
>
