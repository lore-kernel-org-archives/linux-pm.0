From: David C Niemi <dniemi@verisign.com>
Subject: Re: powersave governor runs programs faster and uses more power than
 performance governor
Date: Fri, 25 Oct 2013 10:31:07 -0400
Message-ID: <526A80AB.9070401@verisign.com>
References: <CAMeUXYuuM4LS2qAhhvQi8VG1bK4eiZjjTikchgHzeqi2EX6=bw@mail.gmail.com> <CAOh2x==D_niGhi-fSSW18WQZjEQU+FngvVCB_K+y+3BRfaz96A@mail.gmail.com> <CAMeUXYuQobSo7Au07V2KBE6=mAqXW1Hj--G92FP0X1H97Kv8OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAMeUXYuQobSo7Au07V2KBE6=mAqXW1Hj--G92FP0X1H97Kv8OA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Melanie Kambadur <melanie@cs.columbia.edu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/24/13 15:42, Melanie Kambadur wrote:
> Thank you for your quick and very helpful responses.
>
> A couple of updates. I neglected to RTFM for the cpufreq setter I was
> using :)  When I started to print out the values for all the CPUs
> rather than just the averages as Viresh suggested, I realized that my
> governor settings were only applying to one of the cores at a time. M=
y
> apologies for the silly mistake, I thought I had verified that the
> changes were applied to all of the cores.
>
> After actually applying the frequency governor updates to all of the
> cores (and triple-checking this time), the new results for my
> mini-experiment are still odd. I don't know a good way to share data
> on this forum, please see a snippet of the data at the end of this
> note and let me know if there is a better way to share the complete
> data set. As a summary, the new average frequencies across all the
> cores were:
> performance w/ no apps running =3D 1.13 * 10 ^ 6
> performance w/ apps running =3D 1.33 * 10 ^ 6
> powersave w/ no apps running =3D 1.38 * 10 ^ 6
> powersave w/ apps running =3D 1.95 * 10 ^ 6
>
> I compared these numbers (from cpufreq/cpuinfo_cur_freq) to i7z
> reports and they seem to be reasonable. It's hard to compare
> perfectly, because I can't get i7z to print the frequency values in
> plain text as I would like, but they are definitely in the same
> ballpark (look to be within 100 Mhz).
>
> Obviously, these still aren't the frequency values we'd expect.  I
> think David may be correct that the Dell firmware is somehow
> overriding the linux governors. Here are some more details about my
> server:
> Dell Power Edge R420 with 2 sockets, both:
> Intel=AE Xeon=AE E5-2430 2.20GHz, 15M Cache, 7.2GT/s
> QPI, Turbo, 6C, 95W, Max Mem 1333MHz E52430
> Each socket actually has 6 cores, with dual SMT to make 12 logical
> cores per socket, or 24 total logical cores.
You very definitely need to look at Dell's BIOS power management settin=
gs.  By default they tend to override what you are trying to do at the =
operating system level.  What you probably want is an "OS Control" sett=
ing.

>
> From /sys/devices/system/cpu/cpuN/cpufreq/scaling_driver I get that
> the current p-state driver is called "intel_pstate". David, you
> mention that the firmware governors are not very efficient, do you
> suggest replacing the intel_pstate driver with a different driver? Of
> the drivers listed here:
> https://wiki.archlinux.org/index.php/CPU_Frequency_Scaling#CPU_freque=
ncy_driver
> , I apparently only have available speedstep and p4-clockmod in my
> current kernel. Is one of those better than intel_pstate or will I
> need to download a new driver or even update the kernel to get anothe=
r
> one?
The intel_pstate governor is quite new -- it is both a governor and a d=
river if you want to compare it.  The older more established approach i=
s to use acpi-cpufreq as the driver and Ondemand as the governor, which=
 works quite well for many use cases if properly configured.  We have p=
eople on this list who know intel_idle a lot better than I do, but if D=
ell is using its Active Power Controller intel_idle is not calling the =
shots anyway.

> Also, by C1E do you mean idle state management? I should have given
> some context for my adjustments to the power management policies,
> which is that I am a grad student trying to research how system level
> energy management policies compare to some specific application level
> energy management policies. I would actually like to test a range of
> system level policies, including different kinds of frequency and idl=
e
> state managers. The original goal was to compare a power-optimized
> system version with a performance-optimized version (or a few such
> versions), but I am learning that the options are not so simple. I
> initially thought that on-demand would be the most power-efficient
> frequency governor, but when I noticed that the on-demand governor wa=
s
> missing in my available governors list, I did some digging and
> discovered people writing that on-demand was deprecated for
> Sandy-Bridge (e.g.,
> http://www.phoronix.com/scan.php?page=3Dnews_item&px=3DMTM3NDQ) Is th=
is
> true? On a more general note, does anyone know what the theoretically
> most power- and performance-optimized frequency governors/drivers
> would be for my system setup?
>
> Thanks again,
>
> Melanie
>
> P.S. I haven't yet tried the latest v3.12-rc kernel, and while it is
> an option, I would prefer to get the frequency tuning working on my
> existing kernel to avoid having to re-run some other relevant
> experiments.
>
=2E..
Ondemand works very well for Sandy Bridge if properly configured for yo=
ur intended application.  The new Intel Pstate governor is specifically=
 targeted to Sandy Bridge and later processors, and provides an interes=
ting alternative to Ondemand within that scope, but that does not mean =
Ondemand is "deprecated".  Ondemand is the most common P-State governor=
 across a huge variety of platforms ranging from phones to large server=
s and across many brands of processors besides Intel; it is silly to ca=
ll it "deprecated" just because one of these platforms has an alternati=
ve to it.  In fact many phones have alternatives to Ondemand too, as we=
ll as many platform-specific variants.  Note that there are very big di=
fferences across these platforms -- on phones and other battery-powered=
 devices, power savings are paramount, while on a server, performance u=
nder peak loads is usually paramount.  As for Ted Ts'o's observation, O=
ndemand was originally designed before tickless kernels and it is
obvious it needs to be adapted to not wake up an idle CPU just to asses=
s load in a battery-powered applicaiton.  You might instead want to wak=
e up when you get interrupts due to network activity.  But that is not =
to say managing clock rates is not a good idea, just that we have to ad=
apt and rethink things.

There are two main sides of power management, P States (i.e. clock spee=
d) and C States (i.e. what type of "halt" instruction is used).  intel_=
pstate is of course a manager of P States.  intel_idle and acpi_idle ar=
e C State drivers; most people use the "menu" C state governor and it i=
s just a question of which C State driver to use and how to configure i=
t.

Modern Intel processors rely heavily on having a very effective C1 slee=
p state that the scheduler calls when a core is idle for a short time. =
 C1E is the original standard for an enhanced C1 sleep state but Intel =
continues to improve on it, so you may see references to C1-NHM (Nehale=
m) or C1-SNB (Sandy Bridge) to distinguish feature changes between proc=
essor versions.

A few applications that require very low latency coming out of sleep ma=
y need to avoid sleep states deeper than C1/C1E or C3 (the deeper the s=
leep, the longer it takes to wake up and be ready for productive work).=
  It is almost never a good idea to turn off C1E -- latency to get out =
of C1E is very short and it saves a lot of power vs. "polling" (i.e. ju=
st leaving the core active and having it run a busy wait loop).

DCN

