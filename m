From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 12:21:04 +0200
Message-ID: <200707041221.04708.rjw__5359.71469148553$1183544072$gmane$org@sisk.pl>
References: <fa.ftLWBLCc+XqdYjiuxoPg+qyuUOE@ifi.uio.no>
	<468AE700.7080102@shaw.ca> <20070704003424.GA30958@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070704003424.GA30958@srcf.ucam.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: Robert Hancock <hancockr@shaw.ca>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 4 July 2007 02:34, Matthew Garrett wrote:
> On Tue, Jul 03, 2007 at 06:17:04PM -0600, Robert Hancock wrote:
> > Matthew Garrett wrote:
> > >Leave the process blocked and defer any i/o until after resume. Why does 
> > >it need to be any more complicated than that?
> > 
> > It gets complicated when this has to be added and TESTED in EVERY 
> > driver. The implied contract for drivers previously was that their 
> > device would not get accessed after it was suspended until it had been 
> > resumed first. This proposed change violates that.
> 
> No, that's only ever been true for ACPI systems.

Sorry, but you're mistaken.

Some ARM platforms also use the suspend code in kernel/power and the 52xx
powerpc too (BTW, I don't know of any ARM platforms that support suspend and
don't use it).

> It's never been true elsewhere, and it won't be true for anything
> implementing any sort of runtime power management.

There are not many drivers in the tree supporting that right now.

> > I don't think this sort of handling is something that individual drivers 
> > should have to deal with (at least not ones that are part of a framework 
> > like USB, libata, etc.)
> 
> I'd agree there. Driver midlayers (where they exist) are the appropriate 
> place to handle this.

So perhaps we should modify them first and we can drop the freezer?

Perhaps we can schedule the freezer removal (from the suspend code path), so
that people have the time to rework the driver midlayers to take that into
account?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
