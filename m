From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch] pm: fix runtime powermanagement's
	/sys	interface
Date: Sat, 7 Jan 2006 00:58:07 -0500
Message-ID: <20060107055807.GB3184@neo.rr.com>
References: <20060105221334.GA925@isilmar.linta.de>
	<20060105222338.GG2095@elf.ucw.cz>
	<20060105222705.GA12242@isilmar.linta.de>
	<20060105230849.GN2095@elf.ucw.cz>
	<20060105234629.GA7298@isilmar.linta.de>
	<20060105235838.GC3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
	<20060106001252.GE3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
	<20060106150005.GA20242@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============65114674597286415=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060106150005.GA20242@isilmar.linta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, Patrick Mochel <mochel@digitalimplant.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============65114674597286415==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2006 at 04:00:05PM +0100, Dominik Brodowski wrote:
> Hi,
> 
> On Thu, Jan 05, 2006 at 05:37:30PM -0800, Patrick Mochel wrote:
> > And, appended is a patch to export PM controls for PCI devices. The file
> > "pm_possible_states" exports the states a device supports, and "pm_state"
> > exports the current state (and provides the interface for entering a
> > state).
> 
> Your patch doesn't handle the PM dependencies, unfortunately... 
> 
> Thanks,
> 	Dominik

Physical power dependencies are a very bus and platform specific matter.
I don't expect to see much core level help or infustructure.  I think in
the PCI case, we would first require PCI bus power management support.
This feature is currently nonexistent.  As I understand, PCI express links
are capable of handling much of this at the hardware level, so it's not
especially important for newer hardware.

At the moment, I think the biggest X86 pm dependency issue is ACPI power
resources.

Logical dependencies might be another matter.  For example, if we have a
bus-instance structure at the driver core level, it may make sense to 
call some sort of ->prepare_for_children mechansim before starting up a
child device.

Thanks,
Adam


--===============65114674597286415==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============65114674597286415==--
