From: Kevin Hilman <khilman@ti.com>
Subject: Re: Question about expected behavior when PM runtime is
	disabled
Date: Mon, 20 Jun 2011 16:21:22 -0700
Message-ID: <87sjr45bt9.fsf@ti.com>
References: <Pine.LNX.4.44L0.1106171103020.2143-100000@iolanthe.rowland.org>
	<201106172129.42995.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106172129.42995.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri, 17 Jun 2011 21:29:42 +0200")
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, June 17, 2011, Alan Stern wrote:
>> On Tue, 14 Jun 2011, Rafael J. Wysocki wrote:
>> 
>> > > Then you suggest:
>> > > 
>> > > 	Call pm_runtime_disable after .suspend;
>> > > 
>> > > 	Call pm_runtime_get_noresume and pm_runtime_enable before
>> > > 	.resume;
>> > > 
>> > > 	Call pm_runtime_put_sync after .complete.
>> > > 
>> > > Right?
>> > 
>> > Yes, that would be resonable IMO.
>> 
>> This turns out to be harder than it looks.  If an error occurs, we may
>> run the complete callback for devices that never were suspended or
>> resumed and hence never had their usage_count incremented.  How can we
>> tell that we need to skip the pm_runtime_put_sync for these devices?
>> 
>> Would it be okay to call pm_runtime_put_sync immediately after the
>> resume callback instead of after complete?
>
> Yes, it would.
>
> That said we may be better off by simply reverting commit
> e8665002477f0278f84f898145b1f141ba26ee26 (PM: Allow pm_runtime_suspend() to
> succeed during system suspend).

I'm OK with blocking runtime PM requests after .suspend (and unblocking
before .resume) e.g. protecting the _noirq callbacks, but I hope we
don't have to go back to blocking them before .prepare (and unblocking
after .complete)

Kevin
