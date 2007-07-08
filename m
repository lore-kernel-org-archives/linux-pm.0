From: David Brownell <david-b@pacbell.net>
Subject: Re: Hibernate after alarm wakes from STR
Date: Sun, 8 Jul 2007 13:15:40 -0700
Message-ID: <200707081315.40560.david-b__43725.3024000258$1183925910$gmane$org@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707081217.53071.david-b@pacbell.net>
	<1183923098.2814.8.camel@work>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183923098.2814.8.camel@work>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Richard Hughes <hughsient@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org, rtc-linux@googlegroups.com
List-Id: linux-pm@vger.kernel.org

On Sunday 08 July 2007, Richard Hughes wrote:
> On Sun, 2007-07-08 at 12:17 -0700, David Brownell wrote:
> > 
> > I think so ... although that's unfortunately another difference
> > between the legacy x86-mostly code and the newer RTC framework.
> 
> (sorry for hijacking the thread)

I changed $SUBJECT ...


> Is this the interface should stuff like HAL use to do:
> 
> * Suspend for 10 minutes
> * auto wakeup and then hibernate...

That is, "Suspend-to-RAM" or "standby"?  Yes, assuming that works on
this particular system.  Arguably that would be a direction for
cpuidle to think about too, but I think alarm-driven wakeup is more
ready-to-use at this point.


> I figure we can do a suspend setting the rtc using the ioctls and then
> we wakeup, and HAL has to know that we woke up from the alarm rather
> than from a lid event or keypress.

... although I don't know whether that particular distinction is
made to userspace right now.  ACPI provides a bit like that, and
at least a few other systems can do something analagous.

That is, we may want to provide a bit more information about the
specific event which triggered wakeup.  I don't believe there is
such an interface, in general.

Plus, the notion seems kind of racey to me.  (If you press a key
right while the wakealarm fires, you don't want hibernation..)


> Is this something we can do (or should do) for OLPC and general ACPI?

I'd certainly rather see laptops doing that than what they do now:
running the battery out, and needing filesystem recovery!!

- Dave
