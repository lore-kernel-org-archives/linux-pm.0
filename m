From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v6 4/7] arm64: add PSCI CPU_SUSPEND based cpu_suspend
 support
Date: Wed, 23 Jul 2014 12:15:15 -0400
Message-ID: <CAJ5Y-ea6Z8EDe_kMZ3O3CxGD7k-M9JLKN-iEr7FB=-GwKGhSdA@mail.gmail.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1405958786-17243-5-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1405958786-17243-5-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@linaro.org>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Devicetree List <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Sebastian Capella <sebcape@gmail.com>, Rob Herring <robh+dt@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Bartlomiej
List-Id: linux-pm@vger.kernel.org

On 21 July 2014 12:06, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> This patch implements the cpu_suspend cpu operations method through
> the PSCI CPU SUSPEND API. The PSCI implementation translates the idle state
> index passed by the cpu_suspend core call into a valid PSCI state according to
> the PSCI states initialized at boot through the cpu_init_idle() CPU
> operations hook.
>
> Entry point is set to cpu_resume physical address, that represents the
> default kernel execution address following a CPU reset; for standby
> states the entry point address is useless and will therefore be ignored
> by the PSCI implementation.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/kernel/psci.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index a623c44..bbdf41d 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -21,6 +21,7 @@
>  #include <linux/reboot.h>
>  #include <linux/pm.h>
>  #include <linux/delay.h>
> +#include <linux/slab.h>
>  #include <uapi/linux/psci.h>
>
>  #include <asm/compiler.h>
> @@ -28,6 +29,7 @@
>  #include <asm/errno.h>
>  #include <asm/psci.h>
>  #include <asm/smp_plat.h>
> +#include <asm/suspend.h>
>  #include <asm/system_misc.h>
>
>  #define PSCI_POWER_STATE_TYPE_STANDBY          0
> @@ -65,6 +67,8 @@ enum psci_function {
>         PSCI_FN_MAX,
>  };
>
> +static DEFINE_PER_CPU_READ_MOSTLY(struct psci_power_state *, psci_power_state);
> +
>  static u32 psci_function_id[PSCI_FN_MAX];
>
>  static int psci_to_linux_errno(int errno)
> @@ -93,6 +97,18 @@ static u32 psci_power_state_pack(struct psci_power_state state)
>                  & PSCI_0_2_POWER_STATE_AFFL_MASK);
>  }
>
> +static void psci_power_state_unpack(u32 power_state,
> +                                   struct psci_power_state *state)
> +{
> +       state->id = (power_state & PSCI_0_2_POWER_STATE_ID_MASK) >>
> +                       PSCI_0_2_POWER_STATE_ID_SHIFT;
> +       state->type = (power_state & PSCI_0_2_POWER_STATE_TYPE_MASK) >>
> +                       PSCI_0_2_POWER_STATE_TYPE_SHIFT;
> +       state->affinity_level =
> +                       (power_state & PSCI_0_2_POWER_STATE_AFFL_MASK) >>
> +                       PSCI_0_2_POWER_STATE_AFFL_SHIFT;
> +}
> +
>  /*
>   * The following two functions are invoked via the invoke_psci_fn pointer
>   * and will not be inlined, allowing us to piggyback on the AAPCS.
> @@ -199,6 +215,61 @@ static int psci_migrate_info_type(void)
>         return err;
>  }
>
> +static int cpu_psci_cpu_init_idle(struct device_node *cpu_node,
> +                                 unsigned int cpu)
> +{
> +       int i, ret, count = 0;
> +       struct psci_power_state *psci_states;
> +       struct device_node *state_node;
> +
> +       /*
> +        * If the PSCI cpu_suspend function hook has not been initialized
> +        * idle states must not be enabled, so bail out
> +        */
> +       if (!psci_ops.cpu_suspend)
> +               return -EOPNOTSUPP;
> +
> +       /* Count idle states */
> +       while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> +                                             count)))
> +               count++;
> +
> +       if (!count)
> +               return -ENODEV;
> +
> +       psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
> +       if (!psci_states) {
> +               pr_warn("idle state psci_state allocation failed\n");
> +               return -ENOMEM;
> +       }
> +
> +       for (i = 0; i < count; i++) {
> +               u32 psci_power_state;
> +
> +               state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +
> +               ret = of_property_read_u32(state_node,
> +                                          "arm,psci-suspend-param",
> +                                          &psci_power_state);
> +               if (ret) {
> +                       pr_warn(" * %s missing arm,psci-suspend-param property\n",
> +                               state_node->full_name);
> +                       goto free_mem;
> +               }
> +
> +               pr_debug("psci-power-state %#x index %d\n", psci_power_state,
> +                                                           i);
> +               psci_power_state_unpack(psci_power_state, &psci_states[i]);
> +       }
> +       /* Idle states parsed correctly, initialize per-cpu pointer */
> +       per_cpu(psci_power_state, cpu) = psci_states;
> +       return 0;
> +
> +free_mem:
> +       kfree(psci_states);
> +       return ret;
> +}
> +
>  static int get_set_conduit_method(struct device_node *np)
>  {
>         const char *method;
> @@ -436,8 +507,23 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>  #endif
>  #endif
>
> +static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
> +{
> +       struct psci_power_state *state = __get_cpu_var(psci_power_state);
> +       /*
> +        * idle state index 0 corresponds to wfi, should never be called
> +        * from the cpu_suspend operations
> +        */
> +       if (WARN_ON_ONCE(!index))
> +               return -EINVAL;
> +
> +       return psci_ops.cpu_suspend(state[index - 1],
> +                                   virt_to_phys(cpu_resume));
> +}
> +
>  const struct cpu_operations cpu_psci_ops = {
>         .name           = "psci",
> +       .cpu_init_idle  = cpu_psci_cpu_init_idle,
>  #ifdef CONFIG_SMP
>         .cpu_init       = cpu_psci_cpu_init,
>         .cpu_prepare    = cpu_psci_cpu_prepare,
> @@ -448,5 +534,8 @@ const struct cpu_operations cpu_psci_ops = {
>         .cpu_kill       = cpu_psci_cpu_kill,
>  #endif
>  #endif
> +#ifdef CONFIG_ARM64_CPU_SUSPEND
> +       .cpu_suspend    = cpu_psci_cpu_suspend,
> +#endif
>  };
>
> --
> 1.9.1

Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>

>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
