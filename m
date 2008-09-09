From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Tue, 9 Sep 2008 08:52:59 -0700
Message-ID: <200809090852.59461.david-b__7363.69120791114$1220980975$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0809091014010.2486-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0809091014010.2486-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 09 September 2008, Alan Stern wrote:
> What about case (c): The device uses legacy PM but the wakeup settings =

> have already been handled by the ACPI AML code? =A0There's no need to =

> clear any extra wakeup-related stuff, but it still is necessary to tell =

> the driver about the event.

Good question ... best if Intel answers it.  :0


> (As a matter of fact, I have no idea whether or not Intel's legacy PM =

> for UHCI is implemented in AML. =A0It may vary from one BIOS to another.)

One data point:  on the laptop used to type this message,
the GPE code block includes stuff like this for each UHCI:

        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB3, 0x02)
        }

Without diving into the ICHx specs (which I believe DO have
such details, thanks be!), my first reaction is that this is
not a "case (c)".  Of course, the rest of the AML code is,
as usual, cryptic (I'd rather have C code), and such stuff
might be hidden elsewhere in the event sequence.

- Dave
