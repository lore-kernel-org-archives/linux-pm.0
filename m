From: <purusothaman.ramajothi@wipro.com>
Subject: Re: Need Help to debug resume hangs at schedule()
	function
Date: Mon, 16 May 2011 12:16:28 +0530
Message-ID: <2FC8B95E2C77614C9F13EDC44D58183C01155554@BLR-SJP-MBX01.wipro.com>
References: <2FC8B95E2C77614C9F13EDC44D58183C0108944B@BLR-SJP-MBX01.wipro.com><BANLkTikH9pgTOteqrsL6KjPYndTVa4EyUA@mail.gmail.com><2FC8B95E2C77614C9F13EDC44D58183C010ED5D2@BLR-SJP-MBX01.wipro.com><BANLkTimcxaDd9ctP7hi3eEkFzTuHS-6QYA@mail.gmail.com><2FC8B95E2C77614C9F13EDC44D58183C010ED6A7@BLR-SJP-MBX01.wipro.com>
	<BANLkTimvHyfFS4F6Gv0edXbi=oK6cEkkog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <BANLkTimvHyfFS4F6Gv0edXbi=oK6cEkkog@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: myungjoo.ham@gmail.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

	Thanks for the reply.I reproduced the issue.What happened is when I try to=
 resume, the kernel resumed but somehow suspend operation has been triggere=
d and it immediately went in to deep_sleep.During this time it enters in to=
 "try_to_freeze_tasks" to freeze all the user space threads.But it hanges a=
fter some time when it is trying to resume a user space thread.This I confi=
rmed by adding the printk in the "try_to_freeze_tasks" function.

Is anyone have faced like this issue? =



Regards,
Purusothaman R

-----Original Message-----
From: MyungJoo Ham [mailto:myungjoo.ham@gmail.com] =

Sent: Wednesday, May 04, 2011 6:14 AM
To: Purusothaman Ramajothi (WT01 - Manufacturing & Hi Tech)
Cc: linux-pm@lists.linux-foundation.org
Subject: Re: [linux-pm] Need Help to debug resume hangs at schedule() funct=
ion

On Tue, May 3, 2011 at 6:37 PM,  <purusothaman.ramajothi@wipro.com> wrote:
> Hi,
>
> =A0 =A0 =A0 =A0Thanks for the help.According to my understanding below is=
 the code flow for resume operation in kernel
>
> 1.device_resume()
> 2.dpm_resume()
> 3.dpm_complete()
> 4.thaw_processes()
> 5.thaw_tasks()
> 6.thaw_process()
> 7.schedule ()
>
> I have compared the "resume hang logs" with the "working logs".During res=
ume all my "drivers" and "devices" resumed back.The final function enters i=
s "thaw_processes".I think the kernel hangs around these function.I confirm=
ed this by adding checkpoints in the code flow of deep sleep.Because the lo=
gs I have don't have the printk message "Restarting...tasks done" when the =
kernel hangs.

Well, then, more printk (pr_emerg?) messages? w/ early printk and/or
low-level debugging options?

Besides, if the crash log stops right before "Restarting..." than, the
crash point could be earlier than thaw_processes.
(or are you crashing at oom_killer_enable? well.. that still means you
need more printks)

>
> Can u explain me in what scenarios the kernel can hang around the thaw_pr=
ocesses?
> Please correct me if the above code flow is incorrect.

- There could be a delayed fatal event triggered by earlier operations
(device drivers) that happens right after entering thawing.
- Last a few printk messages may be just not flushed to display at the
crash point.
- Even if it stopped at thaw_process, it does not necessary mean that
something is wrong at thaw_processes. You already have your irqs
enabled and devices are resumed. Even better, some device drivers may
have "delayed resume" feature usually implemented with work struct or
delayed work.

>
> Regards,
> Purusothaman R
>
>
> -----Original Message-----
> From: MyungJoo Ham [mailto:myungjoo.ham@gmail.com]
> Sent: Tuesday, May 03, 2011 12:45 PM
> To: Purusothaman Ramajothi (WT01 - Manufacturing & Hi Tech)
> Cc: linux-pm@lists.linux-foundation.org
> Subject: Re: [linux-pm] Need Help to debug resume hangs at schedule() fun=
ction
>
> On Tue, May 3, 2011 at 3:38 PM, =A0<purusothaman.ramajothi@wipro.com> wro=
te:
>> Hi,
>>
>> =A0 =A0 =A0 =A0Thanks for the reply.I am using 2.6.27.18 kernel.But I th=
ink [Kernel hacking] =3D=3D> [Detect Hung Tasks] is added from 2.6.30 kerne=
l.
>>
>> Is there any patch that I can apply to enable the "detec hung tasks" fea=
ture in 2.6.27 kernekl?
>
> Clone the recent kernel.
> Run git log -- kernel/hung_task.c
> Pick resulting patches (and more patches if required), apply them to
> yours, and resolve conflicts if exist.
>
>>
>> Is there any other way of debugging this issue using software methods?
>
> Add more printks. Store the whole console output somewhere and
> read/filter/search them later.
>
>>
>>
>> Regards,
>> Purusothaman R
>>
>>
>> -----Original Message-----
>> From: MyungJoo Ham [mailto:myungjoo.ham@gmail.com]
>> Sent: Tuesday, May 03, 2011 8:29 AM
>> To: Purusothaman Ramajothi (WT01 - Manufacturing & Hi Tech)
>> Cc: linux-pm@lists.linux-foundation.org
>> Subject: Re: [linux-pm] Need Help to debug resume hangs at schedule() fu=
nction
>>
>> On Mon, May 2, 2011 at 10:52 PM, =A0<purusothaman.ramajothi@wipro.com> w=
rote:
>>> Hi,
>>>
>>>
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I am using 2.6.27.18 kern=
el.My machine is powerpc
>>> architecture.I executed the deep sleep operation by executing the follo=
wing
>>> command:
>>>
>>>
>>>
>>> "echo mem > /sys/power/state"
>>>
>>>
>>>
>>> The suspend opeartion was successful.All the devices and user level thr=
eads
>>> are suspended.
>>>
>>>
>>>
>>> But sometimes during resume my machine hangs.This is not happening
>>> regularly.But it occurs after 60 or 70 times of deep sleep operation.So=
 for
>>> debugging this I have added checkpoints in the flow of deep check.When =
this
>>> issue was produced the kernel hangs around "thaw_tasks" or "schedule"
>>> function of "thaw_processes".These functions are defined in
>>> "kernel/power/process.c".
>>>
>>
>> Have you enabled [Kernel hacking] =3D=3D> [Detect Hung Tasks] and waited
>> more than 120 seconds after the hang?
>>
>>>
>>>
>>> Note: The final printk message "Restarting tasks.....done" was not disp=
layed
>>> when this issue occurred.But all the devices and drivers resumed back.
>>>
>>>
>>>
>>> I was not able to debug this as the reproduciablity rate was too low.Ki=
ndly
>>> help me in solving the issue.
>>
>> Around 1/100 is not that low for a suspend/resume issue. Don't get too
>> frustrated. You will probably encounter much rarer (let's say 1/10000)
>> incidents if you are doing the job with newly produced chips and
>> boards. :D
>>
>> If you have some H/W tracers similar as T32, try it. It helps a lot.
>>
>>>
>>>
>>>
>>> Regards,
>>>
>>> Purusothaman R
>>>
>>>
>>>
>>> Please do not print this email unless it is absolutely necessary.
>>>
>>> The information contained in this electronic message and any attachment=
s to
>>> this message are intended for the exclusive use of the addressee(s) and=
 may
>>> contain proprietary, confidential or privileged information. If you are=
 not
>>> the intended recipient, you should not disseminate, distribute or copy =
this
>>> e-mail. Please notify the sender immediately and destroy all copies of =
this
>>> message and any attachments.
>>>
>>> WARNING: Computer viruses can be transmitted via email. The recipient s=
hould
>>> check this email and any attachments for the presence of viruses. The
>>> company accepts no liability for any damage caused by any virus transmi=
tted
>>> by this email.
>>>
>>> www.wipro.com
>>>
>>> _______________________________________________
>>> linux-pm mailing list
>>> linux-pm@lists.linux-foundation.org
>>> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>>>
>>
>> --
>> MyungJoo Ham, Ph.D.
>> Mobile Software Platform Lab,
>> Digital Media and Communications (DMC) Business
>> Samsung Electronics
>> cell: 82-10-6714-2858
>>
>> Please do not print this email unless it is absolutely necessary.
>>
>> The information contained in this electronic message and any attachments=
 to this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you ar=
e not the intended recipient, you should not disseminate, distribute or cop=
y this e-mail. Please notify the sender immediately and destroy all copies =
of this message and any attachments.
>>
>> WARNING: Computer viruses can be transmitted via email. The recipient sh=
ould check this email and any attachments for the presence of viruses. The =
company accepts no liability for any damage caused by any virus transmitted=
 by this email.
>>
>> www.wipro.com
>>
>
>
>
> --
> MyungJoo Ham, Ph.D.
> Mobile Software Platform Lab,
> Digital Media and Communications (DMC) Business
> Samsung Electronics
> cell: 82-10-6714-2858
>
> Please do not print this email unless it is absolutely necessary.
>
> The information contained in this electronic message and any attachments =
to this message are intended for the exclusive use of the addressee(s) and =
may contain proprietary, confidential or privileged information. If you are=
 not the intended recipient, you should not disseminate, distribute or copy=
 this e-mail. Please notify the sender immediately and destroy all copies o=
f this message and any attachments.
>
> WARNING: Computer viruses can be transmitted via email. The recipient sho=
uld check this email and any attachments for the presence of viruses. The c=
ompany accepts no liability for any damage caused by any virus transmitted =
by this email.
>
> www.wipro.com
>



-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858

Please do not print this email unless it is absolutely necessary. =


The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and ma=
y contain proprietary, confidential or privileged information. If you are n=
ot the intended recipient, you should not disseminate, distribute or copy t=
his e-mail. Please notify the sender immediately and destroy all copies of =
this message and any attachments. =


WARNING: Computer viruses can be transmitted via email. The recipient shoul=
d check this email and any attachments for the presence of viruses. The com=
pany accepts no liability for any damage caused by any virus transmitted by=
 this email. =


www.wipro.com
