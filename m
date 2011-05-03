From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: Need Help to debug resume hangs at schedule()
	function
Date: Tue, 3 May 2011 16:15:01 +0900
Message-ID: <BANLkTimcxaDd9ctP7hi3eEkFzTuHS-6QYA@mail.gmail.com>
References: <2FC8B95E2C77614C9F13EDC44D58183C0108944B@BLR-SJP-MBX01.wipro.com>
	<BANLkTikH9pgTOteqrsL6KjPYndTVa4EyUA@mail.gmail.com>
	<2FC8B95E2C77614C9F13EDC44D58183C010ED5D2@BLR-SJP-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <2FC8B95E2C77614C9F13EDC44D58183C010ED5D2@BLR-SJP-MBX01.wipro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: purusothaman.ramajothi@wipro.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 3, 2011 at 3:38 PM,  <purusothaman.ramajothi@wipro.com> wrote:
> Hi,
>
> =A0 =A0 =A0 =A0Thanks for the reply.I am using 2.6.27.18 kernel.But I thi=
nk [Kernel hacking] =3D=3D> [Detect Hung Tasks] is added from 2.6.30 kernel.
>
> Is there any patch that I can apply to enable the "detec hung tasks" feat=
ure in 2.6.27 kernekl?

Clone the recent kernel.
Run git log -- kernel/hung_task.c
Pick resulting patches (and more patches if required), apply them to
yours, and resolve conflicts if exist.

>
> Is there any other way of debugging this issue using software methods?

Add more printks. Store the whole console output somewhere and
read/filter/search them later.

>
>
> Regards,
> Purusothaman R
>
>
> -----Original Message-----
> From: MyungJoo Ham [mailto:myungjoo.ham@gmail.com]
> Sent: Tuesday, May 03, 2011 8:29 AM
> To: Purusothaman Ramajothi (WT01 - Manufacturing & Hi Tech)
> Cc: linux-pm@lists.linux-foundation.org
> Subject: Re: [linux-pm] Need Help to debug resume hangs at schedule() fun=
ction
>
> On Mon, May 2, 2011 at 10:52 PM, =A0<purusothaman.ramajothi@wipro.com> wr=
ote:
>> Hi,
>>
>>
>>
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I am using 2.6.27.18 kerne=
l.My machine is powerpc
>> architecture.I executed the deep sleep operation by executing the follow=
ing
>> command:
>>
>>
>>
>> "echo mem > /sys/power/state"
>>
>>
>>
>> The suspend opeartion was successful.All the devices and user level thre=
ads
>> are suspended.
>>
>>
>>
>> But sometimes during resume my machine hangs.This is not happening
>> regularly.But it occurs after 60 or 70 times of deep sleep operation.So =
for
>> debugging this I have added checkpoints in the flow of deep check.When t=
his
>> issue was produced the kernel hangs around "thaw_tasks" or "schedule"
>> function of "thaw_processes".These functions are defined in
>> "kernel/power/process.c".
>>
>
> Have you enabled [Kernel hacking] =3D=3D> [Detect Hung Tasks] and waited
> more than 120 seconds after the hang?
>
>>
>>
>> Note: The final printk message "Restarting tasks.....done" was not displ=
ayed
>> when this issue occurred.But all the devices and drivers resumed back.
>>
>>
>>
>> I was not able to debug this as the reproduciablity rate was too low.Kin=
dly
>> help me in solving the issue.
>
> Around 1/100 is not that low for a suspend/resume issue. Don't get too
> frustrated. You will probably encounter much rarer (let's say 1/10000)
> incidents if you are doing the job with newly produced chips and
> boards. :D
>
> If you have some H/W tracers similar as T32, try it. It helps a lot.
>
>>
>>
>>
>> Regards,
>>
>> Purusothaman R
>>
>>
>>
>> Please do not print this email unless it is absolutely necessary.
>>
>> The information contained in this electronic message and any attachments=
 to
>> this message are intended for the exclusive use of the addressee(s) and =
may
>> contain proprietary, confidential or privileged information. If you are =
not
>> the intended recipient, you should not disseminate, distribute or copy t=
his
>> e-mail. Please notify the sender immediately and destroy all copies of t=
his
>> message and any attachments.
>>
>> WARNING: Computer viruses can be transmitted via email. The recipient sh=
ould
>> check this email and any attachments for the presence of viruses. The
>> company accepts no liability for any damage caused by any virus transmit=
ted
>> by this email.
>>
>> www.wipro.com
>>
>> _______________________________________________
>> linux-pm mailing list
>> linux-pm@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>>
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
