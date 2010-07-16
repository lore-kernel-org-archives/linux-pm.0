From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] cpuidle: extend cpuidle and menu governor to
 handle dynamic states
Date: Thu, 15 Jul 2010 21:07:13 -0700
Message-ID: <4C3FDAF1.7030107__9606.64616800404$1279253292$gmane$org@linux.intel.com>
References: <1279225825-31069-1-git-send-email-aili@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1279225825-31069-1-git-send-email-aili@codeaurora.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ai Li <aili@codeaurora.org>
Cc: len.brown@intel.com, dwalker@codeaurora.org, mingo@elte.hu, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, shemminger@vyatta.com
List-Id: linux-pm@vger.kernel.org

On 7/15/2010 1:30 PM, Ai Li wrote:

I'm ok with the general idea, but have a few comments about the 
implementation
> Signed-off-by: Ai Li<aili@codeaurora.org>
> ---
>   drivers/cpuidle/governors/menu.c |   59 +++++++++++++++++++++++++++++--------
>   include/linux/cpuidle.h          |    4 ++
>   2 files changed, 50 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 1b12870..b3854cc 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -271,6 +271,9 @@ static int menu_select(struct cpuidle_device *dev)
>
>   	detect_repeating_patterns(data);
>
> +	if (dev->prepare)
> +		dev->prepare(dev, data->predicted_us);
>    

I don't like the idea of passing predicted_us here.
the states and their updates should be independent of how long we think 
we'll be idle;
it's up to the menu governor to then pick a good one, not for the 
platform to muck with things
based on this.

Also I would like the cpuidle code, not the governor, to call this 
prepare function.
The need to call ->prepare is governor independent....



+ if (dev->compare_power) {

I'm not a big fan of this as a flag; either we always do this, which I 
can understand, or we sort things, which is also fine with me.
Doing this condition like this.... not a fan.
