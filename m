From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/4] cpuidle: move enter_dead to the driver
	structure
Date: Fri, 6 Jul 2012 23:27:18 +0200
Message-ID: <201207062327.18568.rjw@sisk.pl>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>
	<201207052240.57686.rjw@sisk.pl> <4FF6C673.7000003@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FF6C673.7000003@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Friday, July 06, 2012, Daniel Lezcano wrote:
> On 07/05/2012 10:40 PM, Rafael J. Wysocki wrote:
> > On Thursday, July 05, 2012, Daniel Lezcano wrote:
> >> The 'enter_dead' function is only used for processor_idle.c
> >> and the same function is used several times. We fall into the
> >> same abuse with the multiple callbacks for the same function.
> > 
> > This isn't abuse, mind you.  This is a normal practice.
> 
> Well, that depends :)
> 
> I agree adding a callback per state is nice and flexible

Yes, it is.

> but if it is not used, it is a waste of memory, even if it is 32 bytes.

32 bits, perhaps?  And how many of those are there in the whole system,
actually?  Is this a number that actually matters?

> >> This patch fixes that by moving the 'enter_dead' function to the
> >> driver structure. A flag CPUIDLE_FLAG_DEAD_VALID has been added
> >> to handle the callback conditional invokation.
> > 
> > And how does that improve things?
> 
> In order to check if the play_dead is enabled for a specific state, we
> check if the pointer is set. As it has been moved to a single function,
> we need to add a flag to replace this check. That is not an improvement,

Well, exactly.

> it replace a check by another check.

Sorry, but I don't really see the point.

Thanks,
Rafael
