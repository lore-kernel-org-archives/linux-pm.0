From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 7/9] PM: Add suspend blocking work.
Date: Sat, 24 Apr 2010 08:33:48 +0200
Message-ID: <4BD290CC.4080601__4429.37340490079$1272090930$gmane$org@kernel.org>
References: <1271984938-13920-1-git-send-email-arve@android.com>	
	<1271984938-13920-2-git-send-email-arve@android.com>	
	<1271984938-13920-3-git-send-email-arve@android.com>	
	<1271984938-13920-4-git-send-email-arve@android.com>	
	<1271984938-13920-5-git-send-email-arve@android.com>	
	<1271984938-13920-6-git-send-email-arve@android.com>	
	<1271984938-13920-7-git-send-email-arve@android.com>	
	<1271984938-13920-8-git-send-email-arve@android.com>	
	<4BD1576E.5070401@kernel.org> <20100423122032.GA23544@redhat.com>
	<y2ud6200be21004231549q8e52c9c0z441d82b5a15e177d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <y2ud6200be21004231549q8e52c9c0z441d82b5a15e177d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Dmitri Vorobiev <dmitri.vorobiev@movial.com>, Andi Kleen <ak@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On 04/24/2010 12:49 AM, Arve Hj=F8nnev=E5g wrote:
> I want the suspend blocker active when the work is pending or running.
> I did not see a way to do this on top of the workqueue api without
> adding additional locking.

Well, then add additional locking.  suspend_blocker is far away from
being a hot path and there's nothing wrong with additional locking as
long as everything is wrapped inside proper APIs.  Adding stuff to the
core code for things as specific as this is much worse.

> If the work is both queued and starts running on another workqueue
> between "get_wq_data(work) =3D=3D cwq" and "!work_pending(work)", then
> suspend_unblock will be called when it shouldn't. It should work fine
> if I change to it check pending first though, since it cannot move
> back to the current workqueue without locking cwq->lock first.

The code is more fundamentally broken.  Once work->func has started
executing, the work pointer can't be dereferenced as work callback is
allowed to free or re-purpose the work data structure and in the same
manner you can't check for pending status after execution has
completed.

> Or are you talking about the race when the callback is running on
> multiple (cpu) workqueues at the same time. In that case the suspend
> blocker is released when the callback returns from the last workqueue
> is was queued on, not when all the callbacks have returned. On that
> note, is it ever safe to use flush_work and cancel_work_sync for work
> queues on anything other than a single single threaded workqueue?

flush_work() is guaranteed only to flush from the last queued cpu but
cancel_work_sync() will guarantee that no cpu is executing or holding
onto the work.  So, yeah, as long as the limitations of flush_work()
is understood, it's safe.

Going back to the original subject, just add simplistic outside
locking in suspend_blocker_work API (or whatever other name you
prefer).  That will be much cleaner and safer.  Let's think about
moving them into workqueue implementation proper after the number of
the API users grows to hundreds.

Thanks.

-- =

tejun
