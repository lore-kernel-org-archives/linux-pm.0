From: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 09:51:54 -0400
Message-ID: <469631FA.2070405__12846.9984083951$1184248451$gmane$org@rtr.ca>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<4695C096.5080400@goop.org>
	<Pine.LNX.4.64.0707112319550.28090@asgard.lang.hm>
	<200707121446.14170.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707121446.14170.rjw@sisk.pl>
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
Cc: david@lang.hm, Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Thursday, 12 July 2007 08:43, david@lang.hm wrote:
>> On Wed, 11 Jul 2007, Jeremy Fitzhardinge wrote:
>>
>>> Andrew Morton wrote:
..
>> 8. hibernate kernel does syspend-to-ram to put the devices into a known 
>> safe state.
> Again, the devices should be quiesced rather then suspended in this step.

That's just not possible.  The Hibernate kernel will not have all
of the same device drivers as the mainline kernel.  Or at least that's
what people have previously stated here.

..
>>>>  This sounds awesome.  Am I correct in expecting that ultimately the
>>>>  existing hibernation implementation just goes away and we reuse (and hence
>>>>  strengthen) the existing kexec (and kdump?) infrastructure?

No, not so simple.  We still need much of the code to santize devices
upon wakeup from hibernation.   And adding this extra reboot-kernel step
in the midst of hibernate will double the time it takes (ugh).

Currently, TuxOnIce(suspend2) takes about 10 seconds to suspend my notebook.
Switching to this new scheme would double that to 10 seconds to boot/probe,
plus the original 10 seconds to hibernate.  Assuming the new implementation
even comes close to suspend2 speed.

And the complexity and difficulty of setup really scares me.
Right now, we've got a pretty good/fast in-kernel (well, external patch)
that allows my machines to hibernate very quickly, wake up even faster,
and not swap like mad afterwards.  Without any external programs,
initramfs, or extra kernels required.

And we want to replace this with an ultra-complex setup because.. ????

Cheers
