From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspending to disk on FC6 not working
Date: Sun, 1 Oct 2006 07:30:32 +0200
Message-ID: <20061001053032.GB1829@elf.ucw.cz>
References: <EB12A50964762B4D8111D55B764A8454ABBB3D@scsmsx413.amr.corp.intel.com>
	<1159670982.3714.3.camel@soncomputer>
	<20061001032135.GB21796@redhat.com>
	<1159678800.4096.5.camel@soncomputer>
	<20061001050517.GE28868@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061001050517.GE28868@redhat.com>
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

Hi!

>  > I had not noticed it was not loaded. This maybe a bigger problem. With
>  > the latest FC6 kernel this module gets loaded and thus suspend fails. I
>  > rebuilt the same kernel but plopped this patch in. The module does not
>  > want to load:
>  > =

>  > # /sbin/modprobe acpi-cpufreq
>  > FATAL: Error inserting acpi_cpufreq
>  > (/lib/modules/2.6.18-1.2708.cpufreq/kernel/arch/i386/kernel/cpu/cpufre=
q/acpi-cpufreq.ko): No such device
>  > =

>  > This is why suspend works. But now this module won't load.
> =

> Right, what the STICKY patch that you reverted does is it silences the
> failure, by not unloading the module when it fails to init.
> =

> What we want is the best of both worlds: Silence when its loaded and
> init fails, and no module around.  Hmm.

? Using more kernel memory when hardware can't do acpi_cpufreq just to
get a rid of message... seems like very bad tradeoff. ACPI tables are
not hotpluggable, so it _should_ be impossible to load that module...

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
