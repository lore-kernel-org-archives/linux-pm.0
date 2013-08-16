From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
Date: Sat, 17 Aug 2013 08:13:06 +1000
Message-ID: <1376691186.25016.4.camel@pasglop>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Jonas Bonn <jonas@southpole.se>, devicetree@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2013-08-16 at 18:39 +0100, Sudeep KarkadaNagesha wrote:
> +static bool __of_find_n_match_cpu_property(struct device_node *cpun,
> +                       const char *prop_name, int cpu, unsigned int
> *thread)
> +{
> +       const __be32 *cell;
> +       int ac, prop_len, tid;
> +       u64 hwid;
> +
> +       ac = of_n_addr_cells(cpun);
> +       cell = of_get_property(cpun, prop_name, &prop_len);
> +       if (!cell)
> +               return false;
> +       prop_len /= sizeof(*cell);
> +       for (tid = 0; tid < prop_len; tid++) {
> +               hwid = of_read_number(cell, ac);
> +               if (arch_match_cpu_phys_id(cpu, hwid)) {
> +                       if (thread)
> +                               *thread = tid;
> +                       return true;
> +               }
> +               cell += ac;
> +       }
> +       return false;
> +}

The only problem I can see here is if "ac" is not 1, that will not work
for the ibm,ppc-interrupt-server#s case. IE. The latter is always 1 cell
per entry, only "reg" depends on #address-cells.

However that's only a theorical problem since on ppc #address-cells of
/cpus is always 1...

Cheers,
Ben.
