From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 7/9] PM: Add suspend blocking work.
Date: Fri, 23 Apr 2010 22:21:34 -0700
Message-ID: <i2ld6200be21004232221h2c03ec1alb3d1152142e35fda__1616.89888122982$1272086554$gmane$org@mail.gmail.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
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
To: Oleg Nesterov <oleg@redhat.com>
Cc: Dmitri Vorobiev <dmitri.vorobiev@movial.com>, Andi Kleen <ak@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/4/23 Arve Hj=F8nnev=E5g <arve@android.com>:
> On Fri, Apr 23, 2010 at 5:20 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> On 04/23, Tejun Heo wrote:
>>>
>>> On 04/23/2010 03:08 AM, Arve Hj=F8nnev=E5g wrote:
>>> > Allow work to be queued that will block suspend while it is pending
>>> > or executing. To get the same functionality in the calling code often
>>> > requires a separate suspend_blocker for pending and executing work, or
>>> > additional state and locking.
>>>
>>> Hmm... I think this can be implemented as pure wrapper around
>>> workqueue instead of injecting a flag and code into workqueue core.
>>> Adding @fn field to suspend_blocking_work struct and using a custom
>>> work function to call it and then invoke suspend_unblock() should be
>>> enough, right? =A0Oh, dedicated queue functions will be needed too. =A0I
>>> don't think it's wise to meddle with workqueue core code for this.
>>
>> Completely agreed. The patch adds very "strange" hacks into workqueue
>> code to solve the very specific problems.
>>
>
> I want the suspend blocker active when the work is pending or running.
> I did not see a way to do this on top of the workqueue api without
> adding additional locking.
>

I can remove the WORK_STRUCT_SUSPEND_BLOCKING flag and instead add an
argument to __queue_work and __cancel_work_timer (or use separate
copies) if you think that would be better. It would avoid increasing
the alignment requirement of cpu_workqueue_struct, but it will
probably add more code than the current patch.

-- =

Arve Hj=F8nnev=E5g
