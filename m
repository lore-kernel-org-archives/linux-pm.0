From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: Power Mangement Interfaces
Date: Sat, 31 Mar 2007 09:16:13 -0600
Message-ID: <20070331151613.GA8091@cosmic.amd.com>
References: <20070330235759.GC4252@cosmic.amd.com>
	<1175300283.23438.38.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@laptop.org>
In-Reply-To: <1175300283.23438.38.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=unsubscribe>
List-Archive: <http://mailman.laptop.org/pipermail/devel>
List-Post: <mailto:devel@laptop.org>
List-Help: <mailto:devel-request@laptop.org?subject=help>
List-Subscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=subscribe>
Sender: devel-bounces@laptop.org
Errors-To: devel-bounces@laptop.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org

On 31/03/07 02:18 +0200, Johannes Berg wrote:
> On Fri, 2007-03-30 at 17:57 -0600, Jordan Crouse wrote:
> 
> I think the sources file isn't really useful, a
>   grep -l 1 /sys/power/wakeup/*
> should do.

I was just trying to be friendly to folks who may be used to the ACPI
method. 

> About different possible states: I think each of those can have
> different possible wakeup sources, ACPI can afaik go to S4 and still be
> able to configure the wakeup sources. So I suppose this really needs to
> be something like /sys/power/wakeup/<state>/<event> then where <state>
> is one of (currently) "mem", "disk" and "standby". And then change the
> interface of pm_register_wakeup_source to include the state.
> 
> Also, I'm not sure I like the interface with the name of the wakeup
> event set by the platform driver. That will probably lead to
> inconsistencies, a centrally maintained file with items could be nicer.

I considered that - but different platforms and PM methods may have 
radically different events (will WLAN ever be an event that any other x86
platform would use)?

So I thought it best that we allow the platform driver to provide the
name, and then enforce consistancy from the developers. 

> About test mode: there is such a thing for suspend to disk. In fact, if
> you just want to test driver suspend you could use that. See
> the /sys/power/disk file.

Yeah - I stole the idea from there.  That only works when you go down the
suspend to disk path, though, and I wanted to make sure we were going down
our own STR path. We go all the way into our sleep methods (in fact, I used
it to catch an early bug where we were not restoring the stack correctly in
the lowlevel resume function).  I think there are other uses for the test
mode that even extend into the firmware - consider a clocks on test method
that goes as far as setting up the wake events, but never actually turn
off the power rails.

Thanks for your comments.
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>
