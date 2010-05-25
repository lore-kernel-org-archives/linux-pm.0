From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for May 25 (kernel/power, SUSPEND=n)
Date: Tue, 25 May 2010 12:49:23 -0700
Message-ID: <4BFC29C3.1080005__49684.5197667882$1274817168$gmane$org@oracle.com>
References: <20100525142657.c2ae7804.sfr@canb.auug.org.au>
	<20100525084959.4ff9e924.randy.dunlap@oracle.com>
	<201005252124.52108.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005252124.52108.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/25/10 12:24, Rafael J. Wysocki wrote:
> On Tuesday 25 May 2010, Randy Dunlap wrote:
>> On Tue, 25 May 2010 14:26:57 +1000 Stephen Rothwell wrote:
>>
>>> Hi all,
>>>
>>> We are in the merge window again.  I remind you all not to add stuff for
>>> 2.6.36 to your linux-next trees until after 2.6.35-rc1.
>>
>>
>> when CONFIG_SUSPEND=n, CONFIG_OPPORTUNISTIC_SUSPEND=n, CONFIG_PM=y:
>>
>> kernel/power/main.c:66: error: 'pm_states' undeclared (first use in this function)
> 
> Thanks, the patch below fixes this.
> 
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Fix build with CONFIG_SUSPEND unset
> 
> If CONFIG_SUSPEND is unset, pm_state_valid() doesn't build because
> the pm_states[] array is not defined, but pm_state_valid() is only
> used under #ifdef CONFIG_SUSPEND, so don't try to build it if
> CONFIG_SUSPEND is unset.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

Thanks.


> ---
>  kernel/power/main.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-2.6/kernel/power/main.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/main.c
> +++ linux-2.6/kernel/power/main.c
> @@ -61,10 +61,12 @@ static inline int pm_enter_state(int sta
>  
>  static inline bool hibernation_supported(void) { return true; }
>  
> +#ifdef CONFIG_SUSPEND
>  static inline bool pm_state_valid(int state_idx)
>  {
>  	return pm_states[state_idx] && valid_state(state_idx);
>  }
> +#endif /* CONFIG_SUSPEND */
>  
>  static inline int pm_enter_state(int state_idx)
>  {


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
