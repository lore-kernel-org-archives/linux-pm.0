From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] cpuidle: add maintainer entry
Date: Wed, 24 Apr 2013 09:55:45 -0400
Message-ID: <20130424135545.GE13884@titan.lakedaemon.net>
References: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, benh@kernel.crashing.org, linus.walleij@linaro.org, nicolas.ferre@atmel.com, paulus@samba.org, josephl@nvidia.com, kgene.kim@samsung.com, swarren@wwwdotorg.org, magnus.damm@gmail.com, viresh.kumar@linaro.org, plagnioj@jcrosoft.com, lenb@kernel.org, linaro-kernel@lists.linaro.org, arnd@arndb.de, linux-pm@vger.kernel.org, nsekhar@ti.com, rob.herring@calxeda.com, rjw@sisk.pl, horms@verge.net.au, ben-linux@fluff.org, horms+renesas@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 24, 2013 at 03:34:23PM +0200, Daniel Lezcano wrote:
> Currently the cpuidle drivers are spread across the different archs.
> 
> The patch submission for cpuidle are following different path: the cpuidle core
> code goes to linux-pm, the ARM drivers goes to arm-soc or the SoC specific
> tree, sh goes through sh arch tree, pseries goes through PowerPC and
> finally intel goes through Len's tree while acpi_idle goes under linux-pm.
> 
> That makes difficult to consolidate the code and to propagate modifications
> from the cpuidle core to the different drivers.
> 
> Hopefully, a movement has initiated to put the cpuidle drivers into the
> drivers/cpuidle directory like cpuidle-calxeda.c and cpuidle-kirkwood.c
> 
> Add an explicit maintainer entry in the MAINTAINER to clarify the situation
> and prevent new cpuidle drivers to goes to an arch directory.
> 
> The upstreaming process is unchanged: Rafael takes the patches to merge them
> into its tree but with the acked-by from the driver's maintainer. So the header
> must contains the name of the maintainer.
> 
> This organization will be the same than cpufreq.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  MAINTAINERS                        |    7 +++++++
>  drivers/cpuidle/cpuidle-calxeda.c  |    4 +++-
>  drivers/cpuidle/cpuidle-kirkwood.c |    5 +++--
>  3 files changed, 13 insertions(+), 3 deletions(-)

For the kirkwood bit:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
