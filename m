From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [RFC][PATCH] PM / Hibernate: Add sysfs knob to
 control size of memory for drivers
Date: Tue, 17 May 2011 07:34:49 +1000
Message-ID: <4DD19879.5020606@tuxonice.net>
References: <201105100059.25372.rjw@sisk.pl> <201105150056.55601.rjw@sisk.pl>
	<201105151051.38934.Martin@lichtvoll.de>
	<201105151136.22169.rjw@sisk.pl>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105151136.22169.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

On 15/05/11 19:36, Rafael J. Wysocki wrote:
> In fact, if drivers allocated their memory from suspend/hibernate notifiers,
> that would be practically equivalent to setting reserved_size to the total
> amount of memory reserved by the drivers.  However, it may be difficult
> for drivers to predict how much memory they will need at the time the
> notifiers are called (they are called before freezing user space).
> 
> Thus I'm considering a change that will cause device drivers' ->prepare()
> callbacks to be executed before the preallocation of memory takes place.
> In that case the drivers may allocate memory from their ->prepare()
> callbacks _after_ user space has been frozen and that will make more
> sense overall.
> 
> For now, however, I think that exposing reserved_size is the right choice.

Sorry for not commenting earlier - too busy with Drupal development and
only came across this thread by chance (yes, I'm still subscribed to the
PM list, but haven't been reading it. Hibernation isn't high on my list
of priorities at the moment because TOI is feature complete and stable.
I know I'm supposed to be sending you patches, but other things have
been taking the time that would be used for that).

Anyway...

This sounds to me like a great development. As far as TuxOnIce goes,
we've had a knob for ages that has allowed the user to specify an amount
of memory to be kept aside for driver allocations, and we calculate and
report how much they used in the debugging info sysfs entry. Because
TuxOnIce works differently to [u]swsusp, this is the only source of
potential out-of-memory related failures, and the measures just
mentioned made things much more reliable.

If things went in the direction you're suggesting here, they'd get
better again. I'm all in favour!

Regards,

Nigel
