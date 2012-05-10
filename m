From: Colin Cross <ccross@android.com>
Subject: Re: [PATCHv4 4/4] cpuidle: coupled: add parallel barrier
	function
Date: Thu, 10 May 2012 15:47:21 -0700
Message-ID: <CAMbhsRRzc9hPYLZvuwqsOP3RrF1dZVmzM_qfy_xHNL6mhtJzDA@mail.gmail.com>
References: <1336438662-10484-1-git-send-email-ccross@android.com>
	<1336438662-10484-5-git-send-email-ccross@android.com>
	<201205092331.24487.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205092331.24487.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 9, 2012 at 2:31 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, May 08, 2012, Colin Cross wrote:
>> Adds cpuidle_coupled_parallel_barrier, which can be used by coupled
>> cpuidle state enter functions to handle resynchronization after
>> determining if any cpu needs to abort. =A0The normal use case will
>> be:
>>
>> static bool abort_flag;
>> static atomic_t abort_barrier;
>>
>> int arch_cpuidle_enter(struct cpuidle_device *dev, ...)
>> {
>> =A0 =A0 =A0 if (arch_turn_off_irq_controller()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* returns an error if an irq is pending and=
 would be lost
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if idle continued and turned off powe=
r */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 abort_flag =3D true;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
>>
>> =A0 =A0 =A0 if (abort_flag) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* One of the cpus didn't turn off it's irq =
controller */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 arch_turn_on_irq_controller();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINTR;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* continue with idle */
>> =A0 =A0 =A0 ...
>> }
>>
>> This will cause all cpus to abort idle together if one of them needs
>> to abort.
>>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>> Tested-by: Kevin Hilman <khilman@ti.com>
>> Signed-off-by: Colin Cross <ccross@android.com>
>> ---
>> =A0drivers/cpuidle/coupled.c | =A0 37 ++++++++++++++++++++++++++++++++++=
+++
>> =A0include/linux/cpuidle.h =A0 | =A0 =A04 ++++
>> =A02 files changed, 41 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
>> index 93101fb..3e65de1 100644
>> --- a/drivers/cpuidle/coupled.c
>> +++ b/drivers/cpuidle/coupled.c
>> @@ -130,6 +130,43 @@ struct cpuidle_coupled {
>> =A0static cpumask_t cpuidle_coupled_poked_mask;
>>
>> =A0/**
>> + * cpuidle_coupled_parallel_barrier - synchronize all online coupled cp=
us
>> + * @dev: cpuidle_device of the calling cpu
>> + * @a: =A0 atomic variable to hold the barrier
>> + *
>> + * No caller to this function will return from this function until all =
online
>> + * cpus in the same coupled group have called this function. =A0Once an=
y caller
>> + * has returned from this function, the barrier is immediately availabl=
e for
>> + * reuse.
>> + *
>> + * The atomic variable a must be initialized to 0 before any cpu calls
>> + * this function, will be reset to 0 before any cpu returns from this f=
unction.
>> + *
>> + * Must only be called from within a coupled idle state handler
>> + * (state.enter when state.flags has CPUIDLE_FLAG_COUPLED set).
>> + *
>> + * Provides full smp barrier semantics before and after calling.
>> + */
>> +void cpuidle_coupled_parallel_barrier(struct cpuidle_device *dev, atomi=
c_t *a)
>> +{
>> + =A0 =A0 int n =3D dev->coupled->online_count;
>> +
>> + =A0 =A0 smp_mb__before_atomic_inc();
>> + =A0 =A0 atomic_inc(a);
>> +
>> + =A0 =A0 while (atomic_read(a) < n)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> +
>> + =A0 =A0 if (atomic_inc_return(a) =3D=3D n * 2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(a, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 while (atomic_read(a) > n)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> +}
>
> Well, this looks like "wait until all CPUs execute this code". =A0Don't w=
e have
> anything like this already somewhere?
>
>> +
>> +/**
>> =A0 * cpuidle_state_is_coupled - check if a state is part of a coupled s=
et
>> =A0 * @dev: struct cpuidle_device for the current cpu
>> =A0 * @drv: struct cpuidle_driver for the platform
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 6038448..5ab7183 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -183,6 +183,10 @@ static inline int cpuidle_wrap_enter(struct cpuidle=
_device *dev,
>>
>> =A0#endif
>>
>> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>> +void cpuidle_coupled_parallel_barrier(struct cpuidle_device *dev, atomi=
c_t *a);
>> +#endif
>
> Why exactly is the extra Kconfig option necessary?

It prevents compiling in coupled.o (2k text section) on the majority
of kernels that will never use it.
