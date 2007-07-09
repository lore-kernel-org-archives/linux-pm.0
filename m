From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Mon, 09 Jul 2007 20:05:22 +1000
Message-ID: <1183975522.5961.44.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707081517540.11049-100000@netrider.rowland.org>
	<1183929611.3388.303.camel@localhost.localdomain>
	<200707090847.43378.oliver@neukum.org>
	<20070709100204.GN5401@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070709100204.GN5401@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-07-09 at 12:02 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > But I'm not sure it's a good idea in the long run.  Think of a printer 
> > > > daemon, for example.  It shouldn't have to experience unexpected I/O 
> > > > problems merely because someone has decided to put the system to sleep.
> > > 
> > > Why not ? Printer is offline when machine is asleep... trying to print
> 
> ...filesystems are offline, too, when the machine is asleep. Yet,
> unmounting everything on suspend would not result in useful suspend
> support.
> 
> Yes, I believe we should be transparent.

You just compared apple and oranges... Try printing and half way through
the page, suspend your USB bus, and see how the printer reacts.

Ben.
