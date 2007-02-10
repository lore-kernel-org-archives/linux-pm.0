From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Request for testing remote wakeup during STD
Date: Sat, 10 Feb 2007 12:08:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0702101143090.12146-100000@netrider.rowland.org>
References: <1171083048.10170.23.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1171083048.10170.23.camel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 10 Feb 2007, Nigel Cunningham wrote:

> Hi Alan.

> I'd love to be able to help you. My lappy loads ehci and lsusb shows the
> controller, but I'll be darned if I can find the socket! I have other
> things to get done right now, but if no-one beats me to it, I'll try the
> desktop I have - I think that has ehci somewhere.

Thanks, Nigel.  You mean your laptop has an EHCI controller but no USB
ports?  That's odd...

Anyway, here are instructions for you or anyone else who can do the test.  =

(I forgot to include them in the original message.)  Running the test
involves two steps.

The first step is to check that an unpatched system supports Wake-on-USB.  =

This means enabling it in the BIOS and/or in ACPI (whatever that might
entail; I have no idea what's needed) and actually trying it out.  Either
plugging or unplugging a USB device while the system is in STD should wake
the machine up.

The second step is to see whether Wake-on-USB continues to work after
applying the patch mentioned previously.  That's the real question.

It may turn out that _nobody_ has Wake-on-USB working at all... in which =

case we'd have a different problem to solve.

Alan Stern
