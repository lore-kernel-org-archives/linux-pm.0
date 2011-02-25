From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: OPP: opp_find_freq_exact documentation
	fix
Date: Fri, 25 Feb 2011 23:59:37 +0100
Message-ID: <201102252359.38140.rjw__2777.27805446393$1298674915$gmane$org@sisk.pl>
References: <1298618044-8292-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1298618044-8292-1-git-send-email-nm@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, February 25, 2011, Nishanth Menon wrote:
> opp_find_freq_exact documentation has is_available instead
> of available. This also fixes warning with the kernel-doc:
> scripts/kernel-doc drivers/base/power/opp.c >/dev/null
> Warning(drivers/base/power/opp.c:246): No description found for parameter 'available'
> Warning(drivers/base/power/opp.c:246): Excess function parameter 'is_available' description in 'opp_find_freq_exact'
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applied to suspend-2.6/linux-next.

Thanks,
Rafael


> ---
>  drivers/base/power/opp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 2bb9b4c..56a6899 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -222,7 +222,7 @@ int opp_get_opp_count(struct device *dev)
>   * opp_find_freq_exact() - search for an exact frequency
>   * @dev:		device for which we do this operation
>   * @freq:		frequency to search for
> - * @is_available:	true/false - match for available opp
> + * @available:		true/false - match for available opp
>   *
>   * Searches for exact match in the opp list and returns pointer to the matching
>   * opp if found, else returns ERR_PTR in case of error and should be handled
> 
