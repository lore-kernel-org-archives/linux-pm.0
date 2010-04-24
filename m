From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 7/9] PM: Add suspend blocking work.
Date: Sat, 24 Apr 2010 00:21:58 -0700
Message-ID: <r2zd6200be21004240021sfaec0f3ft8a1ea7c1b12ea52a__38501.6234279194$1272093790$gmane$org@mail.gmail.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<1271984938-13920-7-git-send-email-arve@android.com>
	<1271984938-13920-8-git-send-email-arve@android.com>
	<4BD1576E.5070401@kernel.org> <20100423122032.GA23544@redhat.com>
	<y2ud6200be21004231549q8e52c9c0z441d82b5a15e177d@mail.gmail.com>
	<4BD290CC.4080601@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BD290CC.4080601@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Dmitri Vorobiev <dmitri.vorobiev@movial.com>, Andi Kleen <ak@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/4/23 Tejun Heo <tj@kernel.org>:
> Hello,
>
> On 04/24/2010 12:49 AM, Arve Hj=F8nnev=E5g wrote:
>> I want the suspend blocker active when the work is pending or running.
>> I did not see a way to do this on top of the workqueue api without
>> adding additional locking.
>
> Well, then add additional locking. =A0suspend_blocker is far away from
> being a hot path and there's nothing wrong with additional locking as
> long as everything is wrapped inside proper APIs. =A0Adding stuff to the
> core code for things as specific as this is much worse.
>

OK, I'll try to do this. Do you want it in a separate header file as well?

>> If the work is both queued and starts running on another workqueue
>> between "get_wq_data(work) =3D=3D cwq" and "!work_pending(work)", then
>> suspend_unblock will be called when it shouldn't. It should work fine
>> if I change to it check pending first though, since it cannot move
>> back to the current workqueue without locking cwq->lock first.
>
> The code is more fundamentally broken. =A0Once work->func has started
> executing, the work pointer can't be dereferenced as work callback is
> allowed to free or re-purpose the work data structure and in the same
> manner you can't check for pending status after execution has
> completed.
>

I only touch the work structure after the callback has returned for
suspend blocking work, which does not allow that.

>> Or are you talking about the race when the callback is running on
>> multiple (cpu) workqueues at the same time. In that case the suspend
>> blocker is released when the callback returns from the last workqueue
>> is was queued on, not when all the callbacks have returned. On that
>> note, is it ever safe to use flush_work and cancel_work_sync for work
>> queues on anything other than a single single threaded workqueue?
>
> flush_work() is guaranteed only to flush from the last queued cpu but
> cancel_work_sync() will guarantee that no cpu is executing or holding
> onto the work. =A0So, yeah, as long as the limitations of flush_work()
> is understood, it's safe.
>

Sorry, I didn't see the for_each_cpu(cpu, cpu_map) part of
wait_on_work(). cancel_work_sync() does look safe as long as the work
has not moved to completely different workqueue.

> Going back to the original subject, just add simplistic outside
> locking in suspend_blocker_work API (or whatever other name you
> prefer). =A0That will be much cleaner and safer. =A0Let's think about
> moving them into workqueue implementation proper after the number of
> the API users grows to hundreds.
>

OK.

-- =

Arve Hj=F8nnev=E5g
