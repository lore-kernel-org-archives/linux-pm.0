From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 13:30:49 +0200
Message-ID: <200906081330.50045.rjw__44055.2027932883$1244460665$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<200906072347.00580.rjw@sisk.pl> <20090608065419.GA13568@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090608065419.GA13568@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 08 June 2009, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > +config PM_RUNTIME
> > +	bool "Run-time PM core functionality"
> > +	depends on PM
> > +	---help---
> > +	  Enable functionality allowing I/O devices to be put into energy-saving
> > +	  (low power) states at run time (or autosuspended) after a specified
> > +	  period of inactivity and woken up in response to a hardware-generated
> > +	  wake-up event or a driver's request.
> > +
> > +	  Hardware support is generally required for this functionality to work
> > +	  and the bus type drivers of the buses the devices are on are
> > +	  responsibile for the actual handling of the autosuspend requests and
> > +	  wake-up events.
> 
> Halleluya! :-)

I guess this means you like the general idea. ;-)

Well, we've been discussing it for quite a while and since more and more people
are interested, I'm giving it a high priority.

Best,
Rafael
