From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during snapshot/shutdown
Date: Fri, 27 Apr 2007 16:52:12 +0200
Message-ID: <20070427145212.GO22250@elf.ucw.cz>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Nigel Cunningham <nigel@nigel.suspend2.net>
> 
> As explained by Nigel, Sendmail and some other programs look at the
> load average and stop delivering when it gets too high.  The CPU
> intensiveness of suspending to disk pushes the load average up quite
> high but post-resume we shouldn't really take that into account.  Not
> updating the load average therefore makes snapshot/shutdown invisible
> to sendmail and so on.

Is it kernel problem? We _had_ high load, and load average goes down
pretty quickly.

> @@ -1253,9 +1254,18 @@ static inline void calc_load(unsigned lo
>  	if (unlikely(count < 0)) {
>  		active_tasks = count_active_tasks();
>  		do {
> -			CALC_LOAD(avenrun[0], EXP_1, active_tasks);
> -			CALC_LOAD(avenrun[1], EXP_5, active_tasks);
> -			CALC_LOAD(avenrun[2], EXP_15, active_tasks);
> +			/*
> +			 * If we let the load average be updated while
> +			 * snapshot/shutdown, it will be very high
> +			 * post resume. Processes such as some MTAs
> +			 * that stop work while the average is high
> +			 * will be unnecessarily disrupted.
> +			 */
> +			if (likely(!freezer_is_on())) {
> +				CALC_LOAD(avenrun[0], EXP_1, active_tasks);
> +				CALC_LOAD(avenrun[1], EXP_5, active_tasks);
> +				CALC_LOAD(avenrun[2], EXP_15, active_tasks);
> +			}
>  			count += LOAD_FREQ;
>  		} while (count < 0);
>  	}

NAK. This slows down regular operation, at it is 30 lines for what
should have been one (or five).

Just place avenrun[0] = avenrun[1] = avenrun[2] = 0 at strategic place
if you feel strongly about this. Additional points for using Rafael's
"suspend done" notifier so that you don't have to modify suspend core.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
