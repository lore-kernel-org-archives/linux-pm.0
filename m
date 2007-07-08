From: Richard Hughes <hughsient@gmail.com>
Subject: Re: rtc-cmos not supporting RTC_AIE?
Date: Sun, 08 Jul 2007 20:31:38 +0100
Message-ID: <1183923098.2814.8.camel__12525.2374601134$1183923346$gmane$org@work>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707072226.50069.david-b@pacbell.net> <20070708190350.GB20078@dmt>
	<200707081217.53071.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707081217.53071.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org, rtc-linux@googlegroups.com
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-07-08 at 12:17 -0700, David Brownell wrote:
> 
> I think so ... although that's unfortunately another difference
> between the legacy x86-mostly code and the newer RTC framework.

(sorry for hijacking the thread)

Is this the interface should stuff like HAL use to do:

* Suspend for 10 minutes
* auto wakeup and then hibernate.

I figure we can do a suspend setting the rtc using the ioctls and then
we wakeup, and HAL has to know that we woke up from the alarm rather
than from a lid event or keypress.

Is this something we can do (or should do) for OLPC and general ACPI?

Cheers guys.

Richard.
