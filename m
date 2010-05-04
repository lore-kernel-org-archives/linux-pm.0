From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 4/8] PM: suspend_block: Add debugfs file
Date: Tue, 4 May 2010 14:06:07 -0700
Message-ID: <y2jd6200be21005041406j8f632e90l60941174b4f23c71__33302.2054554478$1273007228$gmane$org@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<1272667021-21312-2-git-send-email-arve@android.com>
	<1272667021-21312-3-git-send-email-arve@android.com>
	<1272667021-21312-4-git-send-email-arve@android.com>
	<1272667021-21312-5-git-send-email-arve@android.com>
	<87mxwf533b.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87mxwf533b.fsf@basil.nowhere.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@halobates.de>
Cc: Tejun Heo <tj@kernel.org>, Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-pm@vger.kernel.org

2010/5/4 Andi Kleen <andi@halobates.de>:
> Arve Hj=F8nnev=E5g <arve@android.com> writes:
>>
>> +static int suspend_blocker_stats_show(struct seq_file *m, void *unused)
>> +{
>> + =A0 =A0 unsigned long irqflags;
>> + =A0 =A0 struct suspend_blocker *blocker;
>> +
>> + =A0 =A0 seq_puts(m, "name\tactive\n");
>> + =A0 =A0 spin_lock_irqsave(&list_lock, irqflags);
>> + =A0 =A0 list_for_each_entry(blocker, &inactive_blockers, link)
>> + =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(m, "\"%s\"\t0\n", blocker->name);
>> + =A0 =A0 list_for_each_entry(blocker, &active_blockers, link)
>> + =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(m, "\"%s\"\t1\n", blocker->name);
>> + =A0 =A0 spin_unlock_irqrestore(&list_lock, irqflags);
>
> Could you report the pid here too?
>

Most of the suspend blockers are in the kernel, and does not have a pid.

> The name set by the application might be meaningless or duplicated.
>

Currently all the names set by android user-space are unique but the
pids are not. We can add columns, or extend the name of user space
suspend blockers in the ioctl interface, later if needed.

-- =

Arve Hj=F8nnev=E5g
