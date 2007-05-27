From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Sun, 27 May 2007 23:04:12 +0100
Message-ID: <20070527220412.GC22687__22078.4520185136$1180303504$gmane$org@srcf.ucam.org>
References: <200705272229.21263.rjw@sisk.pl> <200705272231.54535.rjw@sisk.pl>
	<20070527204955.GA22202@srcf.ucam.org>
	<3ae72650705271449q37f523c3t5980541122ab871@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <3ae72650705271449q37f523c3t5980541122ab871@mail.gmail.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, May 27, 2007 at 11:49:30PM +0200, Kay Sievers wrote:

> What exactly is the problem we see here? The timeout of the firmware loader?
> What goes wrong with frozen userspace, usually there is only a netlink
> message sent from the kernel, which should be received and handled
> just fine when userspace is running again.

Driver calls request_firmware in the resume method. The userspace helper 
can't be run because it's been frozen, so the firmware never gets loaded 
and the call times out. The driver then fails to resume. While all this 
is happening, the rest of the kernel is blocking on that resume method. 
The firmware can be loaded once userspace has been started again, but by 
that time the driver has given up.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
