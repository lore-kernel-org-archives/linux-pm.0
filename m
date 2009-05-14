From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: dev->status.power and future of DPM_
Date: Thu, 14 May 2009 11:28:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905141114590.3004-100000@iolanthe.rowland.org>
References: <aec7e5c30905132129v2abb7c72r20fa8b748d42deb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30905132129v2abb7c72r20fa8b748d42deb6@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 14 May 2009, Magnus Damm wrote:

> So let's look at it from a different angle then. Today there are many
> SoCs on the market from multiple vendors, and they all need to be
> power managed somehow. Upstream linux is not very good at it,

The reason is that there aren't enough runtime power management
implementations for anybody to know how a good design should work.  
What parts belong in the core, what parts belong in the driver, what
parts belong in arch-specific code, and so on?  There's no consensus
and so there's no upstream development.

>  some
> vendors have many out-of-tree patches for these things. For SuperH we
> have no power management code out-of-tree so _now_ we have a good
> chance of implementing something upstream that multiple architectures
> can make use of.

Maybe.  If you're really clever about it...

> Paul Walmsley, Kevin Hilman and I discussed this during last Embedded
> Linux Conference last month. From architecture perspective both Arm
> and SuperH need to be able enter deep sleep states. For this to happen
> we need the ability to save and restore device context during run
> time.
> 
> Do you have any recommendation for us?

Device context cannot be saved and restored in a centralized manner, as 
far as I can see.  The requirements vary too widely among the different 
buses and device types.  There's no choice but to rely on individual 
drivers or bus subsystems to take care of the details.

So while it might make sense to have a central core invoke various
methods to tell drivers when certain power-management events need to
happen, the actual details of these events (like the device context or
power state) cannot be handled by the core.  As a corollary, you
shouldn't try to put a bunch of new runtime-PM-related fields in the
core data structures.  And you should think twice about reusing the
fields designed for system PM, because the issues are rather
different.

Even so, there are plenty of difficulties.  What should the various
methods be?  What should the "certain power-management events" be?  
When should they occur?  To be truly acceptable upstream, your
solutions will have to work on everything from a SoC to a
supercomputer.

Solving these problems in the domain of USB alone was reasonably 
straightforward, because there we know exactly what the possible states 
and power transitions are.  Even so, it involved a good deal of code 
and it evolved over a long period of time.  Doing the equivalent for an 
entire system will require a tremendous development effort.

Alan Stern
