From: Jarek Poplawski <jarkao2@o2.pl>
Subject: Re: 2.6.21-mm1 hwsusp: BUG at workqueue.c:106
Date: Tue, 8 May 2007 14:12:33 +0200
Message-ID: <20070508121232.GE1772__8358.9005088017$1178626046$gmane$org@ff.dom.local>
References: <20070508105528.GA86@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070508105528.GA86@tv-sign.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 08-05-2007 12:55, Oleg Nesterov wrote:
> On 05/08, Andrew Morton wrote:
>> On Tue, 08 May 2007 10:57:35 +0200 Jiri Slaby <jirislaby@gmail.com> wrote:
>>
>>> this occured in dmesg during resuming from hwsusp in 2.6.21-mm1 (captured
>>> through netconsole). Perfectly reproducible, it simply happens each time I
>>> try it.
>> Let's cc Oleg.
>>
>>> usb_endpoint usbdev5.1_ep00: PM: resume from 0, parent usb5 still 2
>>> ------------[ cut here ]------------
>>> kernel BUG at /home/l/latest/xxx/kernel/workqueue.c:106!
>>> invalid opcode: 0000 [#1]
>>> SMP
>>> Modules linked in: ipv6 floppy ohci1394 ieee1394 parport_pc parport usbhid
>>> ehci_hcd pata_acpi ff_memless sr_mod cdrom
...
> queue_delayed_work().
> 
> Probably, cancel_delayed_work(&delayed_work->work) was called with the ->timer
> pending. This is wrong, cancel_delayed_work() clears _PENDING unconditionally,

Maybe I miss your point, but clearing is conditional: on timer delete...

I think more suspicious is calling cancel_work_sync() for a delayed work
(with timer pending). Or maybe some race profits from _PENDING cleared
without locking?

BTW, it seems some debugging is needed to show, whose work is doing the
mess.

Regards,
Jarek P.
