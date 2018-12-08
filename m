From: Ken Moffat <zarniwhoop73@googlemail.com>
Subject: Re: Recommended driver for current AMD processors
Date: Sat, 8 Dec 2018 00:47:12 +0000
Message-ID: <CANVEwpZjEeXB7wq5Jzj=Z9A6SYpuQrK4WUetDLEX3e5OCfDLLA@mail.gmail.com>
References: <674a80a7-e956-ef2d-3095-41473851a402@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <674a80a7-e956-ef2d-3095-41473851a402@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: pmenzel@molgen.mpg.de
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, zarniwhoop@ntlworld.com
List-Id: linux-pm@vger.kernel.org

Hi Paul,

On Fri, 7 Dec 2018 at 15:32, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Linux folks,
>
>
> What driver is recommended for current AMD Ryzen based processors
> like *AMD Ryzen 5 PRO 1500 Quad-Core Processor* or *AMD EPYC 7601
> 32-Core Processor*?
>
> Only from the acpi-cpufreq Kconfig description, I assume, that that
> driver should be used.
>
> > config X86_ACPI_CPUFREQ
> >         tristate "ACPI Processor P-States driver"
> >         depends on ACPI_PROCESSOR
> >         help
> >           This driver adds a CPUFreq driver which utilizes the ACPI
> >           Processor Performance States.
> >           This driver also supports Intel Enhanced Speedstep and newer
> >           AMD CPUs.
> >
> >           To compile this driver as a module, choose M here: the
> >           module will be called acpi-cpufreq.
> >
> >           For details, take a look at <file:Documentation/cpu-freq/>.
> >
> >           If in doubt, say N.
>
> Would a =E2=80=9Cnative=E2=80=9D driver like Intel=E2=80=99s P state driv=
er also give better
> results? Do you know if AMD is working on something like that?
>
>
>
> Kind regards,
>
> Paul
>

As a mere user, I bought a ryzen 3 1300X earlier this year, and was
annoyed about how the frequencies changed when a single-threaded
compile moved to a different core (unlike e.g. a haswell where
frequencies barely vary).

I have a meter which can report the current power consumption
for the system (computer, monitor, network switch, kvm switch), and
using that to keep an eye on the range of reported wattages when idle,
compiling with -j1 and compiling with -j4, I eventually formed the
impression that the ondemand governor was marginally better than
the performance governor, and that omitting cpufreq did not appear to
increase the poer consumption.

But that is just one set of observations.  I agree that using less
power and getting faster compiles would be nice, so if something is
available I'll be keen to try it.

=C4=B8en
