From: David Brownell <david-b@pacbell.net>
Subject: Re: [Bugme-new] [Bug 8995] New: /proc/acpi/alarm worked;
	update to 2.6.22.2 and /sys/class/rtc/rtc0/wakealarm don't
Date: Mon, 5 Nov 2007 08:11:17 -0800
Message-ID: <200711050811.18256.david-b@pacbell.net>
References: <bug-8995-10286@http.bugzilla.kernel.org/>
	<200711041125.35163.david-b@pacbell.net>
	<200711042056.56763.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711042056.56763.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>, huffcslists@gmail.com, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 04 November 2007, Rafael J. Wysocki wrote:
> On Sunday, 4 of November 2007, David Brownell wrote:
> >
> > So what's the status of this now ... are we back to having
> > the /sys/class/rtc/rtc0/wakealarm work with ACPI again
> 
> Yes, it should work now.

A current git kernel seemed to work for me on at least one
system that had previously misbehaved ... both "standby" and
"disk" suspend now let the wakealarm do its thing.  (And STR
has the usual unrelated framebuffer issues.)  And I'm told 
another person has seen it work again on his hardware.  I'll
try it on a few other systems too, just to be sure.

Thanks for the bugfix, and update!

- Dave
