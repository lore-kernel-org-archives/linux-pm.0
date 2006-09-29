From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: suspending to disk on FC6 not working
Date: Fri, 29 Sep 2006 15:55:31 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454ABBB3D@scsmsx413.amr.corp.intel.com>
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
To: Dave Jones <davej@redhat.com>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

 =


>-----Original Message-----
>From: Dave Jones [mailto:davej@redhat.com] =

>Sent: Friday, September 29, 2006 3:26 PM
>To: Pallipadi, Venkatesh
>Cc: Louis Garcia; Pavel Machek; linux-pm@lists.osdl.org
>Subject: Re: [linux-pm] suspending to disk on FC6 not working
>
>On Fri, Sep 29, 2006 at 02:35:43PM -0700, Pallipadi, Venkatesh wrote:
> =

> > cpufreq_cpu_data[] =3D NULL; only happens when acpi_cpufreq =

>driver init
> > fails;
> > Looks like acpi_cpufreq driver init is failing at some point in this
> > case and the driver is staying loaded after that failure. =

>That in turn
> > seems similar to one other bug I saw recently.
>
>Ah, that was because it was marked CPUFREQ_STICKY in 2.6.18.
>That was added to work around another problem : If it was =

>built modular,
>a modprobe acpi-cpufreq would be really noisy when it get an -ENODEV
>

That's it.. This issue seems to be a side effect of that patch...

Louis: After normal boot of 2.6.18, if you are not seeing the directory
/sys/devices/system/cpu/cpu0/cpufreq

Then try reverting this patch
http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dc
ommit;h=3D911cb74bb9e77e40749abc2fca6fe74d87d940f3

and then check whether the suspend resume issue goes away. =


Thanks,
Venki
