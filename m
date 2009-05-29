From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Fri, 29 May 2009 16:41:13 +0900
Message-ID: <aec7e5c30905290041p13cc3e48k3527640fb52c3730__11401.4590894387$1243582937$gmane$org@mail.gmail.com>
References: <aec7e5c30905272314s54364f00u9bf5ecf48081dcda@mail.gmail.com>
	<Pine.LNX.4.44L0.0905281129090.3037-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0905281129090.3037-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 29, 2009 at 12:33 AM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> On Thu, 28 May 2009, Magnus Damm wrote:
>
>> On Wed, May 27, 2009 at 11:30 PM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
>> > On Wed, 27 May 2009, Magnus Damm wrote:
>> >> PM: Runtime platform device power management
>>
>> > Have you given any thought as to whether the platform_device_wakeup and
>> > platform_device_idle calls should be restricted to process context?
>>
>> Good question. The first thing that pops into my mind is to have same
>> restrictions as clk_enable() and clk_disable(). To keep things simple
>> I'd say that it's unlikely that any embedded platform driver would
>> need to sleep during the dev_pm_ops callbacks. Maybe it makes sense to
>> only allow _noirq variants of dev_pm_ops, not sure. Any ideas?
>
> I don't know what would be appropriate for you. =A0USB power transitions
> cannot be made in an atomic context, but the situation could well be
> different for platform devices. =A0It's just something to be aware of.

For our SuperH platform devices there should be no need to sleep.

> (And by the way, the _noirq ops don't run in atomic context. =A0They run
> in process context with most interrupt deliveries disabled. =A0It's not
> the same thing -- they are allowed to sleep.)

Huh, so if they are allowed to sleep then clock events are still
running. And probably some clocksource as well. I guess that's why you
say "most" interrupts disabled instead of all. Sharing the timer IRQ
is not allowed then?

I wonder if the PM code assumes that the clock event is a sys device?
We use platform drivers for clock events on SuperH...

/ magnus
