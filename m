From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 4/4] of: move of_get_cpu_node implementation to
 DT core library
Date: Sat, 17 Aug 2013 08:14:33 +1000
Message-ID: <1376691273.25016.5.camel@pasglop>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376674791-28244-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
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
> +#ifdef CONFIG_PPC
> +               /* Check for historical "ibm,ppc-interrupt-server#s" property
> +                * for thread ids on PowerPC. If it doesn't exist fallback to
> +                * standard "reg" property.
> +                */
> +               if (__of_find_n_match_cpu_property(cpun,
> +                               "ibm,ppc-interrupt-server#s", cpu, thread))
> +                       return cpun;
> +#endif

It's not "historical". It's still very much in use and well defined in PAPR :-)

Cheers,
Ben.
