From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: swsusp regression
Date: Tue, 04 Jul 2006 12:25:03 +0159
Message-ID: <44AA4216.4040407@gmail.com>
References: <44A99DFB.50106@gmail.com>	<44A99FE5.6020806@gmail.com>	<20060703161034.a5c4fba9.akpm@osdl.org>	<44A9AD48.5020400@gmail.com>
	<20060703172455.d45edb0a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060703172455.d45edb0a.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-pm@osdl.org, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Andrew Morton napsal(a):
> On Tue, 04 Jul 2006 01:50:09 +0159
> Jiri Slaby <jirislaby@gmail.com> wrote:
> =

>> Andrew Morton napsal(a):
>>> On Tue, 04 Jul 2006 00:53:02 +0159
>>> Jiri Slaby <jirislaby@gmail.com> wrote:
>>>
>>>> Jiri Slaby napsal(a):
>>>>> Hello,
>>>>>
>>>>> when suspending machine with hyperthreading, only Freezing cpus appea=
rs and then
>>>> Note: suspending to disk; done by:
>>>> echo reboot > /sys/power/disk
>>>> echo disk > /sys/power/state
>>>>
>>>>> it loops somewhere. I tried to catch some more info by pressing sysrq=
-p. Here
>>>>> are some captures:
>>>>> http://www.fi.muni.cz/~xslaby/sklad/03072006074.gif
>>>>> http://www.fi.muni.cz/~xslaby/sklad/03072006075.gif
>>>> One more from some previous kernels (cutted sysrq-t):
>>>> http://www.fi.muni.cz/~xslaby/sklad/22062006046.jpg
>>>>
>>> If you replace kernel/stop_machine.c with the version from 2.6.17, does=
 it
>>> help?
>> Yup. It seems so.
>>
> =

> OK.  I don't see what the problem is - let's just revert it.

I dag into that deeply and:
struct task_struct *__stop_machine_run(int (*fn)(void *), void *data,
                                       unsigned int cpu)
{
[...]
        p =3D kthread_create(do_stop, &smdata, "kstopmachine");
        if (!IS_ERR(p)) {
                kthread_bind(p, cpu);
                wake_up_process(p);
                wait_for_completion(&smdata.done);
[...]
So here the thread is created and kernel waits for completion. OK.


static int do_stop(void *_smdata)
{
[...]
        /* We're done: you can kthread_stop us now */
        complete(&smdata->done);

This is called, some work is done, so call complete:
void fastcall complete(struct completion *x)
{
        unsigned long flags;

        spin_lock_irqsave(&x->wait.lock, flags);
        x->done++;
        __wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBL=
E,
                         1, 0, NULL);
        spin_unlock_irqrestore(&x->wait.lock, flags);
}
Nice, but spin_unlock_irqrestore never returns -- it loops in preempt_enabl=
e(),
why? Is TIF_NEED_RESCHED set all the time? Wouldn't be this the culprit?

regards,
-- =

Jiri Slaby        www.fi.muni.cz/~xslaby/
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
<a href=3D"http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
