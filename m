From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v3 1/2] Input: enable i8042-level wakeup
	control
Date: Thu, 28 Jul 2011 17:01:11 +0100
Message-ID: <CAGq3pz53NYr+SzVK8rxFSr_DFA7Rm4=FERVktBFpqZ5=D4AxAQ__6262.71322039447$1311868986$gmane$org@mail.gmail.com>
References: <CAGq3pz6J2pma1TxcqUreQ-qi37Tk4VU15uAvH1=dwyAAvxAPLg@mail.gmail.com>
	<Pine.LNX.4.44L0.1107281136360.1990-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1107281136360.1990-100000@iolanthe.rowland.org>
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
Cc: dtor@mail.ru, linux-pm@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, dilinger@queued.net
List-Id: linux-pm@vger.kernel.org

On 28 July 2011 16:45, Alan Stern <stern@rowland.harvard.edu> wrote:
> My experience in this area is _extremely_ limited. =A0Take a look at
> commits b14e033e17d0ea0ba (PNPACPI: Add support for remote wakeup) and
> 3e6e15a862a0bc201 (Input: enable remote wakeup for PNP i8042 keyboard
> ports).

Thanks for the pointers.

Indeed, in b14e033e17d0ea0ba you are enabling wakeup on pnp (ACPI)
devices, not the actual input device. In the sysfs tree, the pnp
device is completely disconnected from the device hierarchy that
includes the actual input device (the one controlled in
drivers/input/input.c).

By this I mean that with your patch, in order to enable/disable
keyboard wakeups on my non-OLPC laptop I need to:
echo -n disabled > "/sys/bus/pnp/drivers/i8042 kbd/00:06/power/wakeup"

However, the input device that is responsible for my keyboard is
/sys/devices/platform/i8042/serio0/input/input3 - and there is no
linkage between that and the pnp node.

If it would be more appropriate, I could also create a disconnected
and distant /sys node for OLPC's keyboard/mouse wakeup capability,
matching the way that ACPI works. But I thought it would be better to
put the capability directly in the i8042/input device hierarchy.

(and then we have the separate problem with i8042 input devices being
unconditionally reset in 3 layers, losing the event that woke the
system - this would be harder to solve if the wakeup-capable node was
distant/unrelated)

> At this point I have reached my level of incompetence... so I'll shut
> up now. =A0:-)

Cool! I finally found something that you don't know everything about!

Thanks for the help! I'm also new to this area and welcome some kind
of verification/criticism of the design I have come up with.
Daniel
