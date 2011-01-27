From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] PM / Wakeup: Add missing memory barriers
Date: Thu, 27 Jan 2011 14:00:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101271335480.2090-100000__8529.36997912384$1296154965$gmane$org@iolanthe.rowland.org>
References: <201101262353.21043.rjw@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101262353.21043.rjw@novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Jan 2011, Rafael J. Wysocki wrote:

> > Ideally you could do away with the need for synchronization entirely.  
> > For example, events_in_progress and event_count could be stored as two 
> > 16-bit values stuffed into a single atomic variable.  Then they could 
> > both be read or updated simultaneously.
> 
> OK, the patch below appears to work for me.  Can you have a look at it, please?
> 
> Rafael
> 
> 
> ---
>  drivers/base/power/wakeup.c |   82 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 58 insertions(+), 24 deletions(-)
> 
> Index: linux-2.6/drivers/base/power/wakeup.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/wakeup.c
> +++ linux-2.6/drivers/base/power/wakeup.c
> @@ -24,12 +24,48 @@
>   */
>  bool events_check_enabled;
>  
> -/* The counter of registered wakeup events. */
> -static atomic_t event_count = ATOMIC_INIT(0);
> -/* A preserved old value of event_count. */
> +#define EVENT_COUNT_BITS	(sizeof(atomic_t) * 4)

This should be sizeof(int), since atomic_t variables store int values.  
In principle, the atomic_t might include other things along with the 
stored value (it used to, on some architectures).

> +#define MAX_EVENT_COUNT		((1 << EVENT_COUNT_BITS) - 1)
> +
> +/* Combined counters of registered wakeup events and events in progress. */
> +static atomic_t combined_event_count = ATOMIC_INIT(0);
> +

Comment here, explaining that this is needed so that the in_progress 
and count parts can be operated on simultaneously.

> +static unsigned int split_counters(unsigned int *inpr, unsigned int *cnt)
> +{
> +	unsigned int comb = atomic_read(&combined_event_count);
> +
> +	*inpr = (comb >> EVENT_COUNT_BITS);
> +	*cnt = comb & MAX_EVENT_COUNT;

The inpr part is bounded, whereas the cnt part increments without 
limit.  Therefore inpr should occupy the lower bits and cnt should 
occupy the upper bits, where overflow isn't an issue.

> +	return comb;
> +}
> +
> +static unsigned int merge_counters(unsigned int inpr, unsigned int cnt)
> +{
> +	return (inpr << EVENT_COUNT_BITS) | cnt;
> +}
> +
> +static void update_events_in_progress(void)
> +{
> +	unsigned int cnt, inpr, old, new;
> +
> +	do {
> +		old = split_counters(&inpr, &cnt);
> +		new = merge_counters(inpr + 1, cnt);
> +	} while (atomic_cmpxchg(&combined_event_count, old, new) != old);
> +}

Just atomic_inc(&combined_event_count) -- after inpr has been moved to 
the lower bits.

> +
> +static void update_counters(void)
> +{
> +	unsigned int cnt, inpr, old, new;
> +
> +	do {
> +		old = split_counters(&inpr, &cnt);
> +		new = merge_counters(inpr - 1, cnt + 1);
> +	} while (atomic_cmpxchg(&combined_event_count, old, new) != old);
> +}

Just atomic_add(MAX_EVENT_COUNT, &combined_event_count).

The rest looks fine.

Alan Stern
