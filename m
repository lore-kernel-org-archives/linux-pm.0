From: David Brownell <david-b@pacbell.net>
Subject: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR
Date: Fri, 22 Jun 2007 03:08:26 -0700
Message-ID: <200706220308.27447.david-b__43755.1665156663$1182506953$gmane$org@pacbell.net>
References: <20070518071523.GA3195@inferi.kami.home>
	<1182304359.5411.122.camel@localhost.localdomain>
	<200706202339.20188.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706202339.20188.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Mattia Dongili <malattia@linux.it>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 20 June 2007, Rafael J. Wysocki wrote:

> Well, there's nothing interesting in there, AFAICS:
> 
> Device	S-state	  Status   Sysfs node
> P0P4	  S4	 disabled  pci:0000:00:1e.0
> BNIC	  S4	 disabled  pci:0000:02:05.0
> USB1	  S4	 disabled  pci:0000:00:1d.0
> USB2	  S4	 disabled  pci:0000:00:1d.1
> USB3	  S4	 disabled  pci:0000:00:1d.2
> EUSB	  S4	 disabled  pci:0000:00:1d.7
> PS2K	  S4	 disabled  pnp:00:0b
> PS2M	  S4	 disabled  pnp:00:0c

The interesting thing there is that all those devices are
able to wake from S4 state ... including USB controllers.

That's not very common for USB.  EHCI ("EUSB" above) at
least has a spec for how that should work ... it relies on
the PCI Vaux power well to maintain power sessions, though
I don't know that the EHCI code has been tested against
that part of the spec.  UHCI likely relies on black magic
to achieve that effect.

- Dave
