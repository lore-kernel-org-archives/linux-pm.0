From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH update] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 11)
Date: Mon, 3 Aug 2009 12:26:14 +0900
Message-ID: <aec7e5c30908022026t2fa8f328s27424073c9ff560b__8662.70939955047$1249270036$gmane$org@mail.gmail.com>
References: <200907221701.50449.rjw@sisk.pl> <200907222110.47701.rjw@sisk.pl>
	<aec7e5c30907310732u35faa15fpab070025f596463e@mail.gmail.com>
	<200907312053.17914.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907312053.17914.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi again Rafael,

On Sat, Aug 1, 2009 at 3:53 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Friday 31 July 2009, Magnus Damm wrote:
>> [Runtime PM v11]

>> > @@ -202,7 +203,9 @@ int driver_probe_device(struct device_dr
>> > =A0 =A0 =A0 =A0pr_debug("bus: '%s': %s: matched device %s with driver =
%s\n",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv->bus->name, __func__, dev_name(dev=
), drv->name);
>> >
>> > + =A0 =A0 =A0 pm_runtime_get_noresume(dev);
>> > =A0 =A0 =A0 =A0ret =3D really_probe(dev, drv);
>> > + =A0 =A0 =A0 pm_runtime_put_noidle(dev);
>> >
>> > =A0 =A0 =A0 =A0return ret;
>> > =A0}
>>
>> This creates problems when drivers want to performing runtime resume
>> from within probe(). For more details please have a look at "[PATCH
>> 04/04] video: Runtime PM hack for SuperH LCDC driver".
>
> Ah, I see. =A0You'd like to call pm_runtime_get_sync() from .probe(), but=
 that
> sees the usage counter different from zero and exits immediately.

Exactly.

> OTOH, I think we should prevent suspends from racing with .probe() at the=
 core
> level. =A0Hmm.

Doesn't it make more sense to allow runtime suspend and resume to
happen after the pm_runtime_enable() call? What case are you trying to
protect against?

> One possible approach could be to call pm_runtime_resume() from
> sh_mobile_lcdc_probe() instead of pm_runtime_put_noidle(). =A0Then, the p=
latform
> code will have a chance to turn the device on and the later pm_runtime_ge=
t*()
> and pm_runtime_put*() calls will be balanced. =A0Of course, in that case =
the
> pm_runtime_get_noresume() in sh_mobile_lcdc_probe() won't be necessary any
> more. =A0Am I overlooking anything?

So for drivers that want to access hardware from .probe(), calling
pm_runtime_resume() after pm_runtime_enable() in should be enough?

Thanks for your help!

/ magnus
