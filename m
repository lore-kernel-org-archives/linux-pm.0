From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 00:16:06 +0200
Message-ID: <1180304166.3131.66.camel__33562.9658577547$1180304334$gmane$org@lov.localdomain>
References: <200705272229.21263.rjw@sisk.pl>
	<200705272231.54535.rjw@sisk.pl> <20070527204955.GA22202@srcf.ucam.org>
	<3ae72650705271449q37f523c3t5980541122ab871@mail.gmail.com>
	<20070527220412.GC22687@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070527220412.GC22687@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-05-27 at 23:04 +0100, Matthew Garrett wrote:
> On Sun, May 27, 2007 at 11:49:30PM +0200, Kay Sievers wrote:
> 
> > What exactly is the problem we see here? The timeout of the firmware loader?
> > What goes wrong with frozen userspace, usually there is only a netlink
> > message sent from the kernel, which should be received and handled
> > just fine when userspace is running again.
> 
> Driver calls request_firmware in the resume method. The userspace helper 
> can't be run because it's been frozen, so the firmware never gets loaded 
> and the call times out. The driver then fails to resume. While all this 
> is happening, the rest of the kernel is blocking on that resume method. 
> The firmware can be loaded once userspace has been started again, but by 
> that time the driver has given up.

Seems, that's just the broken synchronous firmware loading interface
with the useless timeout handling. The nowait version of the same loader
doesn't time out, and should not have that problem. The sync version
should be removed from the kernel, it just causes all sorts of problems
since it exists.

Userspace should handle the async request just fine when it comes back
running, regardless of the time it was submitted.

Kay
