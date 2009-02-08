From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state	interface
Date: Sun, 8 Feb 2009 06:04:04 -0800
Message-ID: <20090208140404.GA22084@bulgaria.corp.google.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902072337.40046.rjw@sisk.pl>
	<20090208103355.GC14143@elf.ucw.cz>
	<200902081450.46584.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902081450.46584.rjw@sisk.pl>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

["Rafael J. Wysocki" <rjw@sisk.pl>]
> 
> Just to make things crystal clear, in fact I don't like any patches in this
> series.
> 
> The wakelocks seem to be overdesigned to me and the "early suspend" thing
> doesn't really fit our suspend-resume framework, especially after the changes
> made recently to the PCI PM code (and the changes that are going to be made
> to it shortly).

Out of curiosity, do these changes provide a model where the system can
be in suspend 99+% of the time, waking up for specific events
(voice/data telephony, user interaction, etc), and rapidly returning to
suspend when the processing required is complete?  That's the larger
goal that the wakelock design seeks to accomplish, which is working
pretty well for us in shipping mobile devices.

Being in suspend, where periodic user and kernel timers aren't running,
and random userspace threads aren't possibly spinning, rather than just 
being in idle in the lowest power possible state, represent a pretty 
significant power savings.

None of the hardware we're working with has a PCI bus, or ACPI, or much
of any traditional desktop/server pc features, which may account for
some of the difference in outlook and approach here.

Brian
