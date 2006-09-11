From: Pavel Machek <pavel@ucw.cz>
Subject: cpufreq terminally broken [was Re: community PM
	requirements/issues and PowerOP]
Date: Tue, 12 Sep 2006 00:56:17 +0200
Message-ID: <20060911225617.GB13474@elf.ucw.cz>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
	<20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	<20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <4505DDA6.8080603@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: kernel list <linux-kernel@vger.kernel.org>, "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

Hi!

Just for the record... this goes out to the lkml. This discussion was
internal for way too long. (for interested lkml readers, I'm sure
linux-pm mailing list has public archive somewhere).

On Tue 2006-09-12 02:05:26, Eugeny S. Mints wrote:
> Pavel Machek wrote:
> >>>>- PowerOP is only one layer (towards the bottom) in a power managemen=
t =

> >>>>solution.
> >>>>- PowerOP does *not* replace cpufreq
> >>>PowerOP provides userland interface for changing processor
> >>>frequency. That's bad -- duplicate interface.
> >>Basically the biggest problem with cpufreq interface is that cpufreq ha=
s =

> >>"chose
> >>predefined closest to a given frequency" functionality implemented in t=
he
> >>kernel while there is _no_ any reason to have this functionality =

> >>implemented in
> >>the kernel if we have sysfs interface exported by PowerOP in place - yo=
u =

> >>just
> >
> >No, there is reason to keep that in kernel -- so that cpufreq
> >userspace interface can be kept, and so that resulting kernel<->user
> >interface is not ugly.
> Cpuferq defines cpufreq_frequency_table structure in arch independent =

> header while it's arch dependent data structure. A lot of code is built =

> around this invalid basic brick and therefore is invalid: cpufreq tables, =

> interface with cpu freq drivers, etc. Notion of transition latency as it =

> defined by cpufreq is wrong because it's not a function of cpu type but =

> function of current and next operating point. no runtime control on =

> operating points set. it's always the same set of operating points for al=
l =

> system cpus in smp case and no way to define different sets or track any =

> dependencies in case say multi core cpus. insufficient kernel<->user spac=
e =

> interface to handle embedded requirements and no way to extend it within =

> current design. Shall I continue?  Why should then anyone want to keep =

> cpufreq userspace interface just due to keep it?

Yes, please continue. I do not think we can just rip cpufreq interface
out of kernel, and I do not think it is as broken as you claim it
is. Ripping interface out of kernel takes years.

I'm sure cpufreq_frequency_table could be moved to asm/ header if you
felt strongly about that.

I believe we need to fix cpufreq if it is broken for embedded
cases.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
