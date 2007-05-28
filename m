From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 13:51:35 +0200
Message-ID: <1180353095.4242.57.camel@lov.localdomain>
References: <200705272229.21263.rjw@sisk.pl>
	<20070527220412.GC22687@srcf.ucam.org>
	<1180304166.3131.66.camel@lov.localdomain>
	<200705280943.54312.rjw@sisk.pl>
	<20070528111554.GF18807@elf.ucw.cz>
	<1180351493.4242.31.camel@lov.localdomain>
	<6BFA837E-47D4-487F-9D71-FA83D6D865E5@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6BFA837E-47D4-487F-9D71-FA83D6D865E5@cam.ac.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael-Luke Jones <mlj28@cam.ac.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-05-28 at 12:38 +0100, Michael-Luke Jones wrote:
> On 28 May 2007, at 12:24, Kay Sievers wrote:
> 
> > A driver for a bootup-critical device like this should just never
> > release the firmware after the first load. There is absolutely no  
> > point
> > in doing that.
> 
> Bogus argument: is a USB-Ethernet device which needs firmware loading  
> boot-up critical? Not on the surface, but if the device loads root  
> over this device, it suddenly is.

Releasing loaded firmware for anything that needs to handle situations
like this just doesn't make sense.

> This functionality should also be written into the firmware-class  
> (and this fact *is* acknowledged in the sparse documentation).

Yeah, but these are just words, nothing people could use. Unfortunately
the author of this document died a few years ago.

Either the whole idea of userspace firmware-loading should be considered
as a problem impossible to do right because of its unsolvable side
effects. Or at least releasing loaded firmware should be the exception
for drivers which can be sure, that the firmware is not needed in
situations we try to work around here.

Kay
