From: Brian Swetland <swetland@google.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 07:23:04 -0700
Message-ID: <AANLkTikJH=t-67TAeUjgWM1=B86ZKq1b1V4WKHHgrfuH__38725.0201580629$1281018357$gmane$org@mail.gmail.com>
References: <20100804185520.GA2417@srcf.ucam.org>
	<201008042251.08266.rjw@sisk.pl>
	<20100804205654.GA4986@srcf.ucam.org>
	<alpine.DEB.2.00.1008041529530.6545@asgard.lang.hm>
	<AANLkTimRZc2B1=ic-0jrGBX7ahCu=NCoQadCOePGDmh9@mail.gmail.com>
	<alpine.DEB.2.00.1008041554580.6545@asgard.lang.hm>
	<20100804231003.GL24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041616160.6545@asgard.lang.hm>
	<20100805134741.GC20565@srcf.ucam.org>
	<alpine.DEB.2.00.1008050706170.25170@asgard.lang.hm>
	<20100805141620.GA21459@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100805141620.GA21459@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: david@lang.hm, peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 5, 2010 at 7:16 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Thu, Aug 05, 2010 at 07:07:06AM -0700, david@lang.hm wrote:
>> On Thu, 5 Aug 2010, Matthew Garrett wrote:
>>> The decision on whether or not to go to sleep isn't the difficult bit of
>>> this problem space.
>>
>> but isn't that all that wakelocks do? affect the decision on whether or
>> not to go to sleep.
>
> You could think of them that way, but it's not the useful aspect of them
> - that much could be implemented entirely in userspace. Wakelocks
> provide a mechanism for userspace to ensure that it's handled all
> received events before a system suspend takes place.

For userspace or the kernel -- some events may not require userspace
intervention, but do require the kernel to stay awake long enough to
finish chewing on them.  Say perhaps a wifi irq comes in, the wifi
driver/stack needs to process some beacon packets or whatnot.

Brian
