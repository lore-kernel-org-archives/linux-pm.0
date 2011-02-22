From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: Re: [Xen-devel] [PATCH 2/3] xen: use freeze/restore/thaw
 PM events for suspend/resume/chkpt
Date: Tue, 22 Feb 2011 14:09:05 -0800
Message-ID: <AANLkTikrUUG92vQS_ZkdKCZ_+1BahQfAhRB-=8eNNW2o__40039.7594938569$1298412638$gmane$org@mail.gmail.com>
References: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
	<1298157158-5421-3-git-send-email-rshriram@cs.ubc.ca>
	<20110222204320.GB4605@dumpdata.com>
Reply-To: rshriram@cs.ubc.ca
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110222204320.GB4605@dumpdata.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, Iam Campbell <ian.campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 22, 2011 at 12:43 PM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Sat, Feb 19, 2011 at 03:12:37PM -0800, Shriram Rajagopalan wrote:
>> Use PM_FREEZE, PM_THAW and PM_RESTORE power events for
>> suspend/resume/checkpoint functionality, instead of PM_SUSPEND
>> and PM_RESUME. Use of these pm events fixes the Xen Guest hangup
>> when taking checkpoints. When a suspend event is cancelled
>> (while taking checkpoints once/continuously), we use PM_THAW
>> instead of PM_RESUME. PM_RESTORE is used when suspend is not
>> cancelled. See Documentation/power/devices.txt and linux/pm.h
>> for more info about freeze, thaw and restore. The sequence of
>> pm events in a suspend-resume scenario is shown below.
>>
>> =A0 =A0 =A0 =A0 dpm_suspend_start(PMSG_FREEZE);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dpm_suspend_noirq(PMSG_FREEZE);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sysdev_suspend(PMSG_FREEZ=
E);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cancelled =3D suspend_hyp=
ercall()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sysdev_resume();
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dpm_resume_noirq(cancelled ? PMSG_THAW : =
PMSG_RESTORE);
>>
>> =A0 =A0 =A0 =A0dpm_resume_end(cancelled ? PMSG_THAW : PMSG_RESTORE);
>>
>> Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
>> ---
>> =A0drivers/base/power/main.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A08 ++++----
>> =A0drivers/xen/manage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 16 ++++++++--------
>> =A0drivers/xen/xenbus/xenbus_probe_frontend.c | =A0 =A08 +++++---
>> =A03 files changed, 17 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index 8340497..aab4f60 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -233,7 +233,7 @@ static int pm_op(struct device *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0#endif /* CONFIG_SUSPEND */
>> -#ifdef CONFIG_HIBERNATION
>> +#if defined(CONFIG_HIBERNATION) || defined(CONFIG_XEN_SAVE_RESTORE)
>
> Could we just make CONFIG_XEN_SAVE_RESTORE depend on CONFIG_HIBERANTION?
> Like this:
>
>
> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> index 5b54892..838e20c 100644
> --- a/arch/x86/xen/Kconfig
> +++ b/arch/x86/xen/Kconfig
> @@ -38,7 +38,7 @@ config XEN_MAX_DOMAIN_MEMORY
>
> =A0config XEN_SAVE_RESTORE
> =A0 =A0 =A0 =A0bool
> - =A0 =A0 =A0 depends on XEN && PM
> + =A0 =A0 =A0 depends on XEN && PM && HIBERNATION
> =A0 =A0 =A0 =A0default y
>
> =A0config XEN_DEBUG_FS
>
>
On that aspect, just noticed
config PM_SLEEP
        bool
        depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
        default y
we could get rid of XEN_SAVE_RESTORE as the suspend/resume code doesnt
depend on PM_SLEEP
anymore.
