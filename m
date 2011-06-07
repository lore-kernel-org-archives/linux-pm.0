From: Kevin Hilman <khilman@ti.com>
Subject: Re: calling runtime PM from system PM methods
Date: Tue, 07 Jun 2011 15:34:50 -0700
Message-ID: <87pqmpl185.fsf__42043.1396145888$1307486234$gmane$org@ti.com>
References: <Pine.LNX.4.44L0.1106021010360.1913-100000@iolanthe.rowland.org>
	<201106062029.36389.rjw@sisk.pl> <87zkluwqab.fsf@ti.com>
	<201106072332.30464.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106072332.30464.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 7 Jun 2011 23:32:30 +0200")
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday, June 07, 2011, Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>> [..]
>> 
>> > While it is tempting to try to get away with only two PM callbacks per
>> > driver instead of four (or even more), it generally is not doable, simply
>> > because driver callbacks are not executed directly by the core.
>> >
>> > The only way to address the problem of code duplication between .suspend()
>> > and .runtime_suspend() callbacks (and analogously for resume) I see at the
>> > moment is to make those callbacks execute common routines.
>> 
>> Makes sense if the "common routines" are in the driver.  The problem
>> arises when the common routines are not actually in the driver, but are
>> instead at the subsystem (or in this case, device power domain) level.
>
> As Alan said, I'm not sure why that is a problem, because device power
> domain can (and most likely should) provide system suspend callbacks as well
> as runtime PM callbacks.  Those callbacks can be designed to do whatever is
> needed.

Yes, I see now.

For some reason, my runtime PM focus caused me to not consider the
system PM callbacks in the device power domains.  Taking care of things
there should solve my problems.

Sorry for being a bit blind,

Kevin
