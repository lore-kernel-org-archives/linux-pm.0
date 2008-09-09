From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Tue, 9 Sep 2008 14:39:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809091428000.2375-100000__44517.0403145768$1220985997$gmane$org@iolanthe.rowland.org>
References: <200809090852.59461.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809090852.59461.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 9 Sep 2008, David Brownell wrote:

> > (As a matter of fact, I have no idea whether or not Intel's legacy PM =

> > for UHCI is implemented in AML. =A0It may vary from one BIOS to another=
.)
> =

> One data point:  on the laptop used to type this message,
> the GPE code block includes stuff like this for each UHCI:
> =

>         Method (_L0C, 0, NotSerialized)
>         {
>             Notify (\_SB.PCI0.USB3, 0x02)
>         }
> =

> Without diving into the ICHx specs (which I believe DO have
> such details, thanks be!), my first reaction is that this is
> not a "case (c)".  Of course, the rest of the AML code is,
> as usual, cryptic (I'd rather have C code), and such stuff
> might be hidden elsewhere in the event sequence.

Fortunately the interface is extremely simple.  It's an 8-bit register =

in the PCI config space, where the two low-order bits enable =

wakeup detection for each of the two ports.  It won't matter if the =

driver and the AML both try to disable wakeup; the end result should =

work regardless.

Anyway, the real problem here is not to enable or disable wakeup
detection.  It is to determine whether or not the device really did
issue a wakeup request.  With Intel's UHCI this involves reading an I/O
register.  On all the systems I have tried it works even in D3hot, so
we should be okay.

Alan Stern
