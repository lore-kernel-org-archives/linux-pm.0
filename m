From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: runtime PM + idle: allow usage when
	interrupts are disabled
Date: Mon, 23 Aug 2010 08:22:02 -0700
Message-ID: <8762z11hid.fsf__28452.0332272679$1282577008$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1008201006430.1716-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1008201006430.1716-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Fri, 20 Aug 2010 10:14:01 -0400 (EDT)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Thu, 19 Aug 2010, Kevin Hilman wrote:
>
>> > In any case, I don't really like this change.  It seems that we would
>> > be better off preventing the runtime PM calls from occurring in the
>> > first place while interrupts are disabled.  
>> 
>> Why? 
>
> Because that's how the Runtime PM framework was designed.  Drivers 
> expect interrupts to be enabled when their runtime PM callbacks are 
> invoked.  And the framework internally depends on it as well.
>
>> > In fact, it's hard to see what could cause this to happen at all.
>> 
>> As I mentioned in the changelog, this happens when trying to use runtime
>> PM in combination with CPUidle.  As has been suggested elsewhere[1],
>> there is a need to do runtime PM on some devices in combination with CPU
>> idle transitions managed by CPUidle.  However, late in the idle path,
>> at the time we want to manage these IO devices, interrupts are disabled.
>
> Then it isn't really feasible to use the runtime PM framework for those 
> devices.  Not unless the framework is extended with new functions meant 
> to be used without interrupts enabled (in which case it doesn't seem to 
> matter much whether you are in process context or not).
>
>> Currently, on OMAP, we are already managing the power state of certain
>> IO devices along with CPUidle transitions using more brute force
>> methods.  IMO, using runtime PM for this would be a much cleaner
>> approach.  The only obstacle is the assumption that the API must be
>> called with interrupts enabled.
>
> That's a big obstacle.  Why can't you manage these devices earlier, 
> while interrupts are still enabled?

Indeed, that's a good question.  I'm exploring this more thoroughly now.

Kevin
