From: Michael-Luke Jones <mlj28@cam.ac.uk>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 12:38:23 +0100
Message-ID: <6BFA837E-47D4-487F-9D71-FA83D6D865E5@cam.ac.uk>
References: <200705272229.21263.rjw@sisk.pl>
	<20070527220412.GC22687@srcf.ucam.org>
	<1180304166.3131.66.camel@lov.localdomain>
	<200705280943.54312.rjw@sisk.pl>
	<20070528111554.GF18807@elf.ucw.cz>
	<1180351493.4242.31.camel@lov.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1180351493.4242.31.camel@lov.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 28 May 2007, at 12:24, Kay Sievers wrote:

> A driver for a bootup-critical device like this should just never
> release the firmware after the first load. There is absolutely no  
> point
> in doing that.

Bogus argument: is a USB-Ethernet device which needs firmware loading  
boot-up critical? Not on the surface, but if the device loads root  
over this device, it suddenly is.

This functionality should also be written into the firmware-class  
(and this fact *is* acknowledged in the sparse documentation).

Michael-Luke Jones
