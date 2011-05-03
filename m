From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: Need Help to debug resume hangs at schedule()
	function
Date: Tue, 3 May 2011 11:59:22 +0900
Message-ID: <BANLkTikH9pgTOteqrsL6KjPYndTVa4EyUA@mail.gmail.com>
References: <2FC8B95E2C77614C9F13EDC44D58183C0108944B@BLR-SJP-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <2FC8B95E2C77614C9F13EDC44D58183C0108944B@BLR-SJP-MBX01.wipro.com>
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

On Mon, May 2, 2011 at 10:52 PM,  <purusothaman.ramajothi@wipro.com> wrote:
> Hi,
>
>
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I am using 2.6.27.18 kernel=
.My machine is powerpc
> architecture.I executed the deep sleep operation by executing the followi=
ng
> command:
>
>
>
> =93echo mem > /sys/power/state=94
>
>
>
> The suspend opeartion was successful.All the devices and user level threa=
ds
> are suspended.
>
>
>
> But sometimes during resume my machine hangs.This is not happening
> regularly.But it occurs after 60 or 70 times of deep sleep operation.So f=
or
> debugging this I have added checkpoints in the flow of deep check.When th=
is
> issue was produced the kernel hangs around =93thaw_tasks=94 or =93schedul=
e=94
> function of =93thaw_processes=94.These functions are defined in
> =93kernel/power/process.c=94.
>

Have you enabled [Kernel hacking] =3D=3D> [Detect Hung Tasks] and waited
more than 120 seconds after the hang?

>
>
> Note: The final printk message =93Restarting tasks.....done=94 was not di=
splayed
> when this issue occurred.But all the devices and drivers resumed back.
>
>
>
> I was not able to debug this as the reproduciablity rate was too low.Kind=
ly
> help me in solving the issue.

Around 1/100 is not that low for a suspend/resume issue. Don't get too
frustrated. You will probably encounter much rarer (let's say 1/10000)
incidents if you are doing the job with newly produced chips and
boards. :D

If you have some H/W tracers similar as T32, try it. It helps a lot.

>
>
>
> Regards,
>
> Purusothaman R
>
>
>
> Please do not print this email unless it is absolutely necessary.
>
> The information contained in this electronic message and any attachments =
to
> this message are intended for the exclusive use of the addressee(s) and m=
ay
> contain proprietary, confidential or privileged information. If you are n=
ot
> the intended recipient, you should not disseminate, distribute or copy th=
is
> e-mail. Please notify the sender immediately and destroy all copies of th=
is
> message and any attachments.
>
> WARNING: Computer viruses can be transmitted via email. The recipient sho=
uld
> check this email and any attachments for the presence of viruses. The
> company accepts no liability for any damage caused by any virus transmitt=
ed
> by this email.
>
> www.wipro.com
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>

-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
