From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] opp: introduce library for device-specific
	OPPs
Date: Fri, 17 Sep 2010 17:37:06 -0700
Message-ID: <87hbhnq43x.fsf__14100.979807745$1284770297$gmane$org@deeprootsystems.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917153643.GC29739@sirena.org.uk> <4C938EE2.1010307@ti.com>
	<20100917155937.GB29596@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100917155937.GB29596@rakim.wolfsonmicro.main> (Mark Brown's
	message of "Fri, 17 Sep 2010 16:59:37 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Linus Walleij <linus.walleij@stericsson.com>, lkml <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

[trimmed Cc list a bit, as vger bounced my last reply due to header too long]

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Fri, Sep 17, 2010 at 10:53:06AM -0500, Nishanth Menon wrote:
>> Mark Brown had written, on 09/17/2010 10:36 AM, the following:
>
>> >It might be clearer to use some term other than enabled in the code -
>> >when reading I wasn't immediately sure if enabled meant that it was
>> >available to be selected or if it was the active operating point.  How
>> >about 'allowed' (though I'm not 100% happy with that)?
>
>> ;).. The opp is enabled or disabled if it is populated, it is
>> implicit as being available but not enabled- how about active? this
>> would change the opp_enable/disable functions to opp_activate,
>> opp_deactivate..
>
>> Recommendations folks?
>
> The enable/disable thing wasn't so noticable in the API itself, it was
> in the data structures that I found it confusing - the core has a
> different idea about what's going on with the system as a whole compared
> to the decision that an individual device is taking.

Can you clarify your confusion here?  I don't follow the problem you're
raising.

The enabled flag in the internal data structure is set to true when
opp_enable() is called and set to false when opp_disable() is called.
I'm not sure

At least as we're currently using it, this API has know knowlege of what
OPP is currently active on the system.  IOW, it has no idea what the
current frequency/voltage a given device is set to.  It's intended more
like an OPP database with some convience functions to search through the
OPPs and to make OPPs available (or not.)  The users of this API (in our
case, CPUfreq and voltage scaling code) are the ones which
keep track of which OPP is actually in use.

As I write this, I agree with what Phil pointed out; that 'available' is
probably the right name for this flag, instead of 'enabled.'

>> >When reading the description I'd expected to see some facility to
>> >trigger selection of an active operating point in the library (possibly
>> >as a separate call since you might have a bunch of operating points
>> >being updated in quick succession) but it looks like that needs to be
>> >supplied externally at the minute?
>
>> The intent is we use the opp_search* functions to pick up the opp
>> and enable/activate it and disable/deactivate it.
>
> Sure, I get that bit.  What I meant was that I was expecting something
> that would say that changes had been made to the enabled/disabled sets
> and that it'd be a good idea to rescan, especially for cases where the
> devices change their requirements but the OPPs need to be done over a
> larger block.

I guess you're thinking of notifiers, so if the list of available OPPs
changes, a driver could (re)search to see if a more optimal OPP was
available?

Certainly sounds possible, but not sure how useful in practice.  OPP
change decisions are not very often, so any OPP database updates may not
affect a device OPP change currently in progress, but would take effect
the next time that device makes an OPP change.

Either way, this is something that could easily be added if it seems
useful.

Kevin
