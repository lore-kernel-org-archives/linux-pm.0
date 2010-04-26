From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 7/9] PM: Add suspend blocking work.
Date: Mon, 26 Apr 2010 16:06:03 +0200
Message-ID: <20100426140603.GA5702__17630.154224071$1272290969$gmane$org@redhat.com>
References: <1271984938-13920-2-git-send-email-arve@android.com>
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
Content-Disposition: inline
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
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: Dmitri Vorobiev <dmitri.vorobiev@movial.com>, Andi Kleen <ak@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 04/23, Arve Hj=F8nnev=E5g wrote:
>
> On Fri, Apr 23, 2010 at 5:20 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>
> > The unblock code in run_workqueue() is racy,
> > it can unblock after the work was queued on another CPU, cwq->lock can't
> > help.
>
> If the work is both queued and starts running on another workqueue
> between "get_wq_data(work) =3D=3D cwq" and "!work_pending(work)", then
> suspend_unblock will be called when it shouldn't. It should work fine
> if I change to it check pending first though, since it cannot move
> back to the current workqueue without locking cwq->lock first.

It can be queued on the same or different workqueue on another CPU,
right before run_workqueue() does unblock.

But I guess this doesn't matter. You already discussed this all with
Tejun while I was sleeping ;) And I agree very much, the new plan looks
much better imho.

Oleg.
