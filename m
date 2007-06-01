From: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Sat, 02 Jun 2007 00:17:34 +0200
Message-ID: <87hcpr2ubl.fsf__11920.2391397723$1180736262$gmane$org@goat.bogus.local>
References: <878xb35sje.fsf@goat.bogus.local> <200706012237.17375.rjw@sisk.pl>
	<87k5un4bwk.fsf@goat.bogus.local> <200706012340.54394.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, 1 June 2007 23:12, Olaf Dietsche wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>> > On Friday, 1 June 2007 22:27, Olaf Dietsche wrote:
>> >> When I resume, everything seems to come up (fan becomes busy, disk and
>> >> dvd spin up for a short time),
>> >
>> > Hmm, what about the screen?
>> 
>> When the laptop is dead, screen remains black.
>> 
>> When I skip acpi_enter_sleep_state(), the screen works like everything
>> else.
>
> I think you should try s2ram (http://en.opensuse.org/s2ram) as the first step.

It doesn't work. I tried all options "s2ram -f (-s, -p, -m, -r, -a 1, -a 2,
-a 3)" one after the other.

Since the screen (or any other device) works without problems, when I
skip acpi_enter_sleep_state(), I don't think it's screen related.

Regards, Olaf.
