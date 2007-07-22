From: david@lang.hm
Subject: Re: Power Management framework proposal
Date: Sun, 22 Jul 2007 11:56:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707221130380.6350__43137.852746486$1185130763$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185125189.2714.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1185125189.2714.13.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 22 Jul 2007, Arjan van de Ven wrote:

>> this approach would allow the transition of ALL drivers to the new mode of
>> operation in one fell swoop, and then adding additional power management
>> features is just adding to the existing list rather then implementing new
>> functions.
>
>
> I have a concern with this approach though. It seems to assume that
> there is one global thing somewhere that sets the system state; in my
> experience that is the wrong approach; in fact there is a very definite
> evidence that there are many decisions on power that are to be made
> local at a high frequency. An example of this is the processor speed;
> the ondemand governer does exactly this for the cpus that can switch
> speeds fast; it's just impossible to beat such a local, fast decision
> with anything on a global scale.

the intent was not to have one global call that sets the mode on all 
devices, but rather have one call for each device/subsystem, just the same 
call in each case.

there's also nothing that says that there can only be one thing setting 
the mode (although that does mean a fourth call 'report_current_mode()' or 
similar is needed). and if you choose to have two pieces of software 
managing the same device things could get 'interesting'.

as for the speed that such decisions need to be made.

this API is not saying anything about the speed of the decisions.
it's also not saying anything about if the decision makeing is being done 
by kernelspace or userspace. it's just providing a common way for whatever 
software is doing the decision makeing to find out it's options and set 
the modes.

one way to represent this in sysfs (as a possible userspace API) would be
power/mode (read to see what mode the device is in, write to set the mode)
power/modelist
power/switching_delay (outputs the delay matrix showing the cost of switching from mode to mode)
although I'm not sure how you would allow the system to report an error 
this way.

if you have the ondemand governer running, it uses these API's to make 
it's changes, but if you didn't want to run the ondemand governer you 
could just do course speed settings through sysfs.

> On the other hand, some things (the high level goals and constraints)
> are obviously global.
>
> However, your design seems to want to put the low level settings in a
> global thing, and that is just a mistake.

I'm proposing a single function name per device, not a single function for 
the entire system.

David Lang
