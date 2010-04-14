From: Salman Qazi <sqazi@google.com>
Subject: Re: [PATCH 1/3] [kidled]: introduce kidled.
Date: Wed, 14 Apr 2010 08:41:30 -0700
Message-ID: <o2y4352991a1004140841w7f37b84cnedcd91c2638a07ea__34783.1804574982$1271259932$gmane$org@mail.gmail.com>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
	<20100414000823.29004.98991.stgit@bumblebee1.mtv.corp.google.com>
	<87fx2y9xdn.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87fx2y9xdn.fsf@basil.nowhere.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: ranjitm@google.com, peterz@infradead.org, linux-kernel@vger.kernel.org, csadler@google.com, kenchen@google.com, dawnchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, akpm@linux-foundation.org, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 14, 2010 at 2:49 AM, Andi Kleen <andi@firstfloor.org> wrote:
> Salman <sqazi@google.com> writes:
>> +
>> +static int proc_stats(struct ctl_table *table, int write,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __user *buffer, size_t *lenp,=
 loff_t *ppos)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 unsigned long stats[3];
>> + =A0 =A0 int cpu =3D (int)((long)table->extra1);
>> + =A0 =A0 struct ctl_table fake =3D {};
>> +
>> + =A0 =A0 if (write)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 fake.data =3D stats;
>> + =A0 =A0 fake.maxlen =3D 3*sizeof(unsigned long);
>> +
>> + =A0 =A0 ret =3D smp_call_function_single(cpu, getstats, &stats, 1);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>
> Haven't read the whole thing, but do any of these stats really
> need to execute on the target CPU? They seem to be just readable
> fields.

To capture all the quantities for a CPU atomically, they must be read
on the CPU.  Basically, reading them on that CPU prevents them from
changing as we read them.

Also, if the CPU is idle (injected or otherwise), the quantities won't
get updated.

>
> Or does it simply not matter because this proc call is too infrequent?

It should be infrequent.  The idle cycle injector does all the hard
work.  These interfaces are for monitoring.

>
> Anyways global broadcasts are discouraged, there is typically
> always someone who feels their RT latency be messed up by them.


I will look at it one more time to see if there is something else that
can be done.

>
> -Andi
>
>
> --
> ak@linux.intel.com -- Speaking for myself only.
>
