From: Colin Cross <ccross@android.com>
Subject: Re: [PATCHv2 3/5] cpuidle: add support for states that
 affect multiple cpus
Date: Thu, 15 Mar 2012 17:20:08 -0700
Message-ID: <CAMbhsRS3J2vruru8i4r1-cB9aJLYW9y1bP0vv7=L3q1JP77ttg@mail.gmail.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
	<1331749794-8056-4-git-send-email-ccross@android.com>
	<87lin18l7o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87lin18l7o.fsf@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: Len Brown <len.brown@intel.com>, Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 15, 2012 at 5:04 PM, Kevin Hilman <khilman@ti.com> wrote:
> Colin Cross <ccross@android.com> writes:
>
>> +/**
>> + * cpuidle_coupled_cpu_set_alive - adjust alive_count during hotplug tr=
ansitions
>> + * @cpu: target cpu number
>> + * @alive: whether the target cpu is going up or down
>> + *
>> + * Run on the cpu that is bringing up the target cpu, before the target=
 cpu
>> + * has been booted, or after the target cpu is completely dead.
>> + */
>> +static void cpuidle_coupled_cpu_set_alive(int cpu, bool alive)
>> +{
>> + =A0 =A0 struct cpuidle_device *dev;
>> + =A0 =A0 struct cpuidle_coupled *coupled;
>> +
>> + =A0 =A0 mutex_lock(&cpuidle_lock);
>> +
>> + =A0 =A0 dev =3D per_cpu(cpuidle_devices, cpu);
>> + =A0 =A0 if (!dev->coupled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 coupled =3D dev->coupled;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* waiting_count must be at least 1 less than alive_count, b=
ecause
>> + =A0 =A0 =A0* this cpu is not waiting. =A0Spin until all cpus have noti=
ced this cpu
>> + =A0 =A0 =A0* is not idle and exited the ready loop before changing ali=
ve_count.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 while (atomic_read(&coupled->ready_count))
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> +
>> + =A0 =A0 smp_mb__before_atomic_inc();
>> + =A0 =A0 atomic_inc(&coupled->alive_count);
>
> This doesn't look quite right. =A0alive_count is incrmented whether the
> CPU is going up or down?
>
> Maybe I misunderstood something, but I don't see anywhere where
> alive_count is decrmemented after a CPU is removed.

Oops, dropped the atomic_dec when I merged from two separate functions
for up and down to a single function that takes a bool.

>> + =A0 =A0 smp_mb__after_atomic_inc();
>> +
>> + =A0 =A0 if (alive)
>> + =A0 =A0 =A0 =A0 =A0 =A0 coupled->requested_state[dev->cpu] =3D CPUIDLE=
_COUPLED_NOT_IDLE;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 coupled->requested_state[dev->cpu] =3D CPUIDLE=
_COUPLED_DEAD;
>> +
>> +out:
>> + =A0 =A0 mutex_unlock(&cpuidle_lock);
>> +}
>> +
