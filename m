From: Kevin Hilman <khilman@ti.com>
Subject: Re: calling runtime PM from system PM methods
Date: Wed, 15 Jun 2011 18:17:46 -0700
Message-ID: <87boxytw05.fsf__34979.9676253044$1308187218$gmane$org@ti.com>
References: <Pine.LNX.4.44L0.1106111227580.3439-100000@netrider.rowland.org>
	<201106120046.36618.rjw@sisk.pl> <87fwna3gnb.fsf@ti.com>
	<201106160201.47123.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106160201.47123.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 16 Jun 2011 02:01:46 +0200")
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Wednesday, June 15, 2011, Kevin Hilman wrote:

[...]

>>
>> From a device driver perspective, system PM is just runtime
>> PM where the "idleness" was forced and only a subset of possible wakeup
>> sources are enabled.
>
> Oh well, I wonder how much of a difference would make you think those things
> are really different. ;-)

Seeing a description of the differences would help.  So far the list is
rather short: wakeups and forcibly quieting the hardware.

I guess I still don't see why system PM cannot be viewed as a special
case of runtime PM, so how about a specific question: From a device
driver perspective, how is system PM anything other than
manually/forcibly creating the right conditions for a runtime PM
transition to happen?

[...]

>> The development effort is primarily
>> focused on implementing efficient runtime PM for an _active_ system.
>> When this is working, implementing system PM is easy: all that is needed
>> is to enable/disable relevant wakeups and force the device to idle.
>> This allows runtime PM to trigger, and the device is suspended.
>
> No, it doesn't.  What you're trying to do is to "maunally" trigger runtime PM

No.  

What I'm trying to do in .suspend() is create the conditions necessary
such that a runtime PM transition will occur *by itself*.  If the right
conditions exist (namely, idle HW, no pending activity, etc.) a runtime
PM transition will happen *on its own*, and will not need to be manually
triggered.  IOW, a runtime PM transition is a side effect of creating
the right idle conditions.

> when _you_ think is suitable.

No, only when a system suspend is requested by the user.

Kevin
