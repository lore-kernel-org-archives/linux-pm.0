From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [PATCH V3] cpuidle: Add a sysfs entry to disable
 specific C state for debug purpose.
Date: Mon, 5 Mar 2012 14:20:46 +0200
Message-ID: <CAGF5oy_BUytjeDa8Oc62pRabaEqwqKCFuVJuzLd-XNZg34ne2w@mail.gmail.com>
References: <C6CB66606345BC4B80CBE69D22ABFBB1021C7F@SHSMSX101.ccr.corp.intel.com>
	<1330647453.1916.7.camel@ymzhang>
	<20120302142303.648285a7.akpm@linux-foundation.org>
	<C6CB66606345BC4B80CBE69D22ABFBB10220E1@SHSMSX101.ccr.corp.intel.com>
	<4F545A4E.8010801@linux.vnet.ibm.com> <4F5466C4.2090808@intel.com>
	<20120305101827.GA19408@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120305101827.GA19408@khazad-dum.debian.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Brown, Len" <len.brown@intel.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, ShuoX Liu <shuox.liu@intel.com>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, greg@kroah.com, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello,


On Mon, Mar 5, 2012 at 12:18 PM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> On Mon, 05 Mar 2012, ShuoX Liu wrote:
>> @@ -45,6 +46,7 @@ total 0
>> =A0/sys/devices/system/cpu/cpu0/cpuidle/state1:
>> =A0total 0
>> =A0-r--r--r-- 1 root root 4096 Feb =A08 10:42 desc
>> +-rw-r--r-- 1 root root 4096 Feb =A08 10:42 disable
>> =A0-r--r--r-- 1 root root 4096 Feb =A08 10:42 latency
>> =A0-r--r--r-- 1 root root 4096 Feb =A08 10:42 name
>> =A0-r--r--r-- 1 root root 4096 Feb =A08 10:42 power
>
> ...
>
>> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
>> index 3fe41fe..1eae29a 100644
>> --- a/drivers/cpuidle/sysfs.c
>> +++ b/drivers/cpuidle/sysfs.c
>> @@ -222,6 +222,9 @@ struct cpuidle_state_attr {
>> =A0#define define_one_state_ro(_name, show) \
>> =A0static struct cpuidle_state_attr attr_##_name =3D __ATTR(_name, 0444,
>> show, NULL)
>>
>> +#define define_one_state_rw(_name, show, store) \
>> +static struct cpuidle_state_attr attr_##_name =3D __ATTR(_name, 0644,
>> show, store)
>> +
>> =A0#define define_show_state_function(_name) \
>> =A0static ssize_t show_state_##_name(struct cpuidle_state *state, \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct cpuidle_state_usag=
e *state_usage, char *buf) \
>> @@ -229,6 +232,19 @@ static ssize_t show_state_##_name(struct
>> cpuidle_state *state, \
>> =A0 =A0 =A0 return sprintf(buf, "%u\n", state->_name);\
>> =A0}
>>
>> +#define define_store_state_function(_name) \
>> +static ssize_t store_state_##_name(struct cpuidle_state *state, \
>> + =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t size) \
>> +{ \
>> + =A0 =A0 int value; \
>> + =A0 =A0 sscanf(buf, "%d", &value); \
>> + =A0 =A0 if (value) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 state->disable =3D 1; \
>> + =A0 =A0 else \
>> + =A0 =A0 =A0 =A0 =A0 =A0 state->disable =3D 0; \
>> + =A0 =A0 return size; \
>> +}
>
> Isn't this missing a check for capabilities? =A0Disabling cpuidle states =
is
> not something random Joe (and IMHO that does mean random capability-
> restricted Joe root) should be doing...
>
> Also, maybe it would be best to use one of the lib helpers to parse that
> value, so that it will be less annoying to userspace (trim blanks, compla=
in
> if there is trailing junk after trimming, etc)?

I may be jumping the thread in the middle but, if it is for debug
purposes, as states the subject, shouldn't this entry go to debugfs
instead of sysfs? I know cpuidle has all the infrastructure there to
simply add another sysfs entry, but if the intent is to create a debug
capability, then I'd say it fits under debugfs instead.  Adding Greg
KH here, as I suppose he may have strong opinion on using sysfs for
debugging.

Of course, if you are targeting user space control over C states on
production  systems, then it's a different thing then.

>
> --
> =A0"One disk to rule them all, One disk to find them. One disk to bring
> =A0them all and in the darkness grind them. In the Land of Redmond
> =A0where the shadows lie." -- The Silicon Valley Tarot
> =A0Henrique Holschuh
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm



-- =


Eduardo Valentin
