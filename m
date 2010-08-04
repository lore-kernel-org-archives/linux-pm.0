From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 16:49:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008041643490.6545__45094.2208212384$1280965876$gmane$org@asgard.lang.hm>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<201008042251.08266.rjw@sisk.pl>
	<20100804205654.GA4986@srcf.ucam.org>
	<alpine.DEB.2.00.1008041529530.6545@asgard.lang.hm>
	<AANLkTimRZc2B1=ic-0jrGBX7ahCu=NCoQadCOePGDmh9@mail.gmail.com>
	<alpine.DEB.2.00.1008041554580.6545@asgard.lang.hm>
	<AANLkTingom2AKfMu0EbfdfLiMnHo+buy1e4=PBENf3Vi@mail.gmail.com>
	<alpine.DEB.2.00.1008041620010.6545@asgard.lang.hm>
	<20100804233013.GN24163@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100804233013.GN24163@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Aug 2010, Paul E. McKenney wrote:

> On Wed, Aug 04, 2010 at 04:23:43PM -0700, david@lang.hm wrote:
>> On Wed, 4 Aug 2010, Arve Hj?nnev?g wrote:
>>
>>>
>>> We suspend as soon as no wakelocks are held. There is no delay.
>>
>> So, if I have a bookreader app that is not allowed to get the
>> wakelock, and nothing else is running, the system will suspend
>> immediatly after I click a button to go to the next page? it will
>> not stay awake to give me a chance to read the page at all?
>>
>> how can any application run without wakelock privilages?
>
> Isn't a wakelock held as long as the display is lit, so that the
> system would continue running as long as the page was visible?

what holds this wakelock, and what sort of timeout does it have? (and why 
could that same timeout be used in other ways instead)

how many apps really need to keep running after the screen blanks? there 
are a few (audio output apps, including music player and Navigation 
directions), but I don't have see a problem with them being marked as the 
'trusted' apps to pay attention instead.

if the backlight being on holds the wakelock, it would seem that almost 
every other use of the wakelock could (and probably should) be replaced by 
something that tickles the display to stay on longer.

David Lang
