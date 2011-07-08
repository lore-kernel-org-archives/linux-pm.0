From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 5/7] PM: PM notifier error injection
Date: Sat, 9 Jul 2011 00:56:15 +0900
Message-ID: <CAC5umyifMvVTG29JyvBtc_YThorK=AZHZypheUvbtvmShnbTog__20943.9974431463$1310140632$gmane$org@mail.gmail.com>
References: <1309702581-16863-1-git-send-email-akinobu.mita@gmail.com>
	<1309702581-16863-6-git-send-email-akinobu.mita@gmail.com>
	<201107072314.59052.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107072314.59052.rjw@sisk.pl>
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
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

>> --- a/kernel/power/main.c
>> +++ b/kernel/power/main.c
>> @@ -42,6 +42,36 @@ int pm_notifier_call_chain(unsigned long val)
>> =A0 =A0 =A0 return notifier_to_errno(ret);
>> =A0}
>>
>> +#ifdef CONFIG_PM_NOTIFIER_ERROR_INJECTION
>> +
>> +static struct err_inject_notifier_block err_inject_pm_notifier =3D {
>> + =A0 =A0 .actions =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 { ERR_INJECT_NOTIFIER_ACTION(PM_HIBERNATION_PR=
EPARE) },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { ERR_INJECT_NOTIFIER_ACTION(PM_SUSPEND_PREPAR=
E) },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { ERR_INJECT_NOTIFIER_ACTION(PM_RESTORE_PREPAR=
E) },
>> + =A0 =A0 =A0 =A0 =A0 =A0 {}
>
> Why have you omitted the PM_POST_* actions?

Because the callbacks of PM_POST_* are not supposed to fail (i.e.
the return value of pm_notifier_call() is ignored).

>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1043,6 +1043,14 @@ config CPU_NOTIFIER_ERROR_INJECTION
>> =A0 =A0 =A0 =A0 # echo 0 > /sys/devices/system/cpu/cpu1/online
>> =A0 =A0 =A0 =A0 bash: echo: write error: Operation not permitted
>>
>> +config PM_NOTIFIER_ERROR_INJECTION
>> + =A0 =A0 bool "PM notifier error injection"
>> + =A0 =A0 depends on PM_DEBUG && NOTIFIER_ERROR_INJECTION
>> + =A0 =A0 help
>> + =A0 =A0 =A0 This option provides the ability to inject artifical error=
s to
>> + =A0 =A0 =A0 PM notifier chain callbacks. =A0It is controlled through d=
ebugfs
>> + =A0 =A0 =A0 interface under /sys/kernel/debug/pm-notifier-error-inject/
>
> I'm not sure the help is necessary. =A0I think it should be selected
> automatically if both PM_DEBUG and NOTIFIER_ERROR_INJECTION are set.

OK, I'll try to tweak the option to be better.
