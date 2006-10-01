From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspending to disk on FC6 not working
Date: Sun, 1 Oct 2006 14:28:19 +0200
Message-ID: <200610011428.20557.rjw@sisk.pl>
References: <EB12A50964762B4D8111D55B764A8454ABBCA8@scsmsx413.amr.corp.intel.com>
	<20061001052203.GF28868@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061001052203.GF28868@redhat.com>
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
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sunday, 1 October 2006 07:22, Dave Jones wrote:
> On Sat, Sep 30, 2006 at 10:07:16PM -0700, Pallipadi, Venkatesh wrote:
> =

>  > >I had not noticed it was not loaded. This maybe a bigger problem. With
>  > >the latest FC6 kernel this module gets loaded and thus suspend fails.=
 I
>  > >rebuilt the same kernel but plopped this patch in. The module does not
>  > >want to load:
>  > >
>  > ># /sbin/modprobe acpi-cpufreq
>  > >FATAL: Error inserting acpi_cpufreq
>  > >(/lib/modules/2.6.18-1.2708.cpufreq/kernel/arch/i386/kernel/cpu
>  > >/cpufreq/acpi-cpufreq.ko): No such device
>  > >
>  > >This is why suspend works. But now this module won't load.
>  > >
>  > =

>  > The module was not working on your laptop even when suspend was failin=
g.
>  > That is what the absence of /sys.../cpufreq says. If this module was
>  > working for you earlier and stopped working recently or even otherwise
>  > both this and speedstep-centrino does not work on your platform, that =
is
>  > a separate issue. Was this module working and cpufreq supported on your
>  > system with any earlier kernels?
> =

> One problem acpi-cpufreq faces when built modular compared to the
> other cpufreq drivers is that there's no way of knowing before modprobe'i=
ng
> whether or not it's going to do anything or not, so userspace never knows
> if it's really 'safe' to load this module.
> =

> In Fedora, we modprobe the acpi-cpufreq module if all other scaling
> drivers have failed their init routines. Ie, it's treated as a fallback
> "Well, nothing else worked, lets try this, and if this don't work out, ba=
il..."
> When we added this userspace 'fallback', we started getting a bunch of
> reports like the above, from users who had CPUs that couldn't do any scal=
ing
> at all. The STICKY tag was added to the driver so that it would stop
> making noise for those users.
> =

> Looking at the problem differently, we *could* add back the sticky tag,
> and add some explicit checks for !data in the suspend/resume paths
> to abort cleanly. It's a bit of a hack though.
> =

> hmm?

Well, IMHO, making the module load when we know it won't work is a hack
in the first place. :-)

If you want the sticky tag, the suspend/resume thing should be added too.

Greetings,
Rafael


-- =

You never change things by fighting the existing reality.
		R. Buckminster Fuller
