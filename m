From: "Kay Sievers" <kay.sievers@vrfy.org>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Sun, 27 May 2007 23:49:30 +0200
Message-ID: <3ae72650705271449q37f523c3t5980541122ab871__31345.3926974491$1180302640$gmane$org@mail.gmail.com>
References: <200705272229.21263.rjw@sisk.pl> <200705272231.54535.rjw@sisk.pl>
	<20070527204955.GA22202@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070527204955.GA22202@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 5/27/07, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Sun, May 27, 2007 at 10:31:53PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Use a hibernation and suspend notifier to disable the firmware requesting
> > mechanism before a hibernation/suspend and enable it after the operation.
>
> This avoids the problem of .resume methods calling userspace while
> userspace is frozen and a resulting hang, but does it actually result in
> the drivers beginning to work again? If we remove process freezing in
> STR, this should just work[1] without the need to complicate things. On
> the other hand, if we don't want to support these functions in the
> suspend and resume methods we could just audit the kernel and remove
> them all.

What exactly is the problem we see here? The timeout of the firmware loader?
What goes wrong with frozen userspace, usually there is only a netlink
message sent from the kernel, which should be received and handled
just fine when userspace is running again.

Thanks,
Kay
