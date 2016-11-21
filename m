From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] PM / Domains: Introduce domain-performance-state
 binding
Date: Mon, 21 Nov 2016 09:07:08 -0600
Message-ID: <20161121150708.j4gosfr2uetc7mwp@rob-hp-laptop>
References: <cover.1479459752.git.viresh.kumar@linaro.org>
 <cce951c7159aa235792959ce27546be3aaa554ec.1479459752.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cce951c7159aa235792959ce27546be3aaa554ec.1479459752.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nayak Rajendra <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 18, 2016 at 02:53:12PM +0530, Viresh Kumar wrote:
> Some platforms have the capability to configure the performance state of
> their Power Domains. The performance levels are represented by positive
> integer values, a lower value represents lower performance state.
> 
> The power-domains until now were only concentrating on the idle state
> management of the device and this needs to change in order to reuse the
> infrastructure of power domains for active state management.
> 
> This patch introduces a new optional property for the consumers of the
> power-domains: domain-performance-state.
> 
> If the consumers don't need the capability of switching to different
> domain performance states at runtime, then they can simply define their
> required domain performance state in their node directly. Otherwise the
> consumers can define their requirements with help of other
> infrastructure, for example the OPP table.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index e1650364b296..db42eacf8b5c 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -106,6 +106,12 @@ domain provided by the 'parent' power controller.
>   - power-domains : A phandle and PM domain specifier as defined by bindings of
>                     the power controller specified by phandle.
>  
> +Optional properties:
> +- domain-performance-state: A positive integer value representing the minimum
> +  performance level (of the parent domain) required by the consumer for its
> +  working. The integer value '1' represents the lowest performance level and the
> +  highest value represents the highest performance level.

How does one come up with the range of values? It seems like you are 
just making up numbers. Couldn't the domain performance level be an OPP 
in the sense that it is a collection of clock frequencies and voltage 
settings?

Rob
