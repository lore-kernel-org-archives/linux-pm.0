From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/4] PM: Use a different list of devices
 for each stage of device suspend
Date: Sun, 12 Dec 2010 22:40:10 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012122237360.4379-100000__32521.3020937101$1292211670$gmane$org@netrider.rowland.org>
References: <201012130129.55483.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012130129.55483.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 13 Dec 2010, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Instead of keeping all devices in the same list during system suspend
> and resume, regardless of what suspend-resume callbacks have been
> executed for them already, use separate lists of devices that have
> had their ->prepare(), ->suspend() and ->suspend_noirq() callbacks
> executed.  This will allow us to simplify the core device suspend and
> resume routines.

Okay in principle.  But there's one mistake...

> @@ -699,8 +693,8 @@ static void dpm_complete(pm_message_t st
>  	INIT_LIST_HEAD(&list);
>  	mutex_lock(&dpm_list_mtx);
>  	transition_started = false;
> -	while (!list_empty(&dpm_list)) {
> -		struct device *dev = to_device(dpm_list.prev);
> +	while (!list_empty(&dpm_prepared_list)) {
> +		struct device *dev = to_device(dpm_prepared_list.prev);
>  
>  		get_device(dev);
>  		if (dev->power.status > DPM_ON) {

The parts about getting rid of "list" and putting dev back onto
dpm_list got left out.

Alan Stern
