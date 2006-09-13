From: "David Singleton" <daviado@gmail.com>
Subject: Re: [linux-pm] cpufreq terminally broken [was Re: community PM requirements/issues and PowerOP]
Date: Wed, 13 Sep 2006 16:50:43 -0700
Message-ID: <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	 <b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
	 <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	 <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	 <20060911225617.GB13474@elf.ucw.cz>
	 <20060912001701.GC14234@linux.intel.com>
	 <20060912033700.GD27397@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751252AbWIMXup@vger.kernel.org>
In-Reply-To: <20060912033700.GD27397@kroah.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Greg,
   here's a few paragraphs about the power management code I'm working on.
The OpPoint patch set is a fully functionaly power management solution,
from kernel operating state support to userland power manager.

OpPoint constructs operating points for all supported frequency, voltage
and suspend states for PC and SoC solutions running Linux.  OpPoint
does not break or replace cpufreq.  It leverages cpufreq code to provide
the same driver scaling functions when cpu frequency changes affect drivers.

(The ARM pxa27x patch uses the cpufreq scaling routines to scale the LCD
when frequencies are changed and works well when playing mpeg movies on
the LCD during frequency scaling operations).

The Operating Points in OpPoint are simply created at compile time, in
the same manner cpufreq tables are, and registered in
/sys/power/operating_states directory when the cpu is identified at boot time.

The states are ordered by name on their power consumption level from lowest
to highest so the power manager can operate correctly regardless of what
frequencies or voltages are associated with the lowest or highest
operating points.

There is no kernel interface to parse and create all the parameters
needed to create an operating point.  Platform specific information
is supplied to the oppoint structure through an ops vector of three
routines and a void * pointer to supply the platform specific data,
in the same manner drivers have a void * for their private data.

The ops vectors provide operating point specific functions to prepare
to change to a new operating point, transition to the target operating
point, and a finish transition routine to either notify driver that
the clocks have scaled and operation of bus and DMA traffic may continue.

OpPoint draws the line about what's needed in the kernel a bit differently
than Matt's PowerOp code.  OpPoint only puts operating point support in
the kernel.  Polices for operting states and classes of operating states
are left to the power manager, in userland.  This simplifies the
kernel code, no string parsers for operating point parameter construction,
and makes it easier to customize a solution by customizing the power
manager.

A power manager is supplied with the OpPoint patch set as well.  I borrowed
the cpuspeed deamon and made a simple patch that uses the new OpPoint
sysfs interface.  The daemon can be compiled as the original cpuspeed or
oppointd deamon depending on the users choice.  The daemon provides the
same functions as the cpuspeed daemon.

OpPoint is a fully functional solution ready for testing and evaluation
in Andrew's or your tree.

The kernel patches are available at:

        http://source.mvista.com/~dsingleton/2.6.1-rc6

the power manager source code and patch is available at:

        http://source.mvista.com/~dsingleton/oppointd


David
