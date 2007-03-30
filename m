From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Power Mangement Interfaces
Date: Fri, 30 Mar 2007 17:57:59 -0600
Message-ID: <20070330235759.GC4252@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: devel@laptop.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hey all -

I'm happy to report that the OLPC power management effort is proceeding
nicely.  We have suspend to RAM functional, and the system is resuming
back to the framebuffer console.  We have the usual blips (USB), but
those will be resolved in the fullness of time.

I am now turning my attention to handling wakeup events - in particular,
events that we can set at run-time.  My thoughts on the matter are 
detailed here:

http://wiki.laptop.org/go/Power_Management_Interface

I use the ACPI wakeup infrastructure as an example because a) it exists,
and b) it works.  However, it doesn't share nicely, and it is a /proc
file, so I sat down and thought of a more /sysfs friendly and generic
model.  I did keep APCI in mind, figuring that if a generic framework was
designed well enough, they could slowly transition over as well (which is
why the ACPI list is CCed).

Comments are welcome.

Jordan

PS: If you have a XO machine, and you're interested in trying out power
management for yourself, documentation and information is forthcoming.
If you can't wait, pop in to #olpc on irc.freenode.net, and somebody 
there will help you get started.

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


