From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Mon, 4 Jun 2007 23:02:45 +0200
Message-ID: <200706042302.45628.rjw__19316.818440757$1180990670$gmane$org@sisk.pl>
References: <878xb35sje.fsf@goat.bogus.local> <200706041013.49428.rjw@sisk.pl>
	<87hcpnpt4k.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87hcpnpt4k.fsf@goat.bogus.local>
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
To: Olaf Dietsche <olaf.dietsche@olafdietsche.de>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, 4 June 2007 18:43, Olaf Dietsche wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Sunday, 3 June 2007 23:20, Olaf Dietsche wrote:
> >
> >> But either way the script never reaches "shutdown -rn now". So, it
> >> seems, that my laptop does a full resume every other reboot, but it
> >> never returns to userspace.
> >
> > I'm still suspecting that the problem is related to your graphics adapter.
> 
> Maybe it's the most common problem, but why do you think so? Even with
> a black screen the kernel should return to userspace.

Not necessarily.  I have a test box that just crashes if the graphics card is
not posted.
 
> > What graphics adapter do you have in the box?
> 
> 0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0148 (rev a2) (prog-if 00 [VGA])
> 	Subsystem: QUANTA Computer Inc: Unknown device 0729
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0, Cache Line Size: 0x08 (32 bytes)
> 	Interrupt: pin A routed to IRQ 10
> 	Region 0: Memory at c4000000 (32-bit, non-prefetchable) [size=64M]
> 	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=128M]
> 	Region 3: Memory at c1000000 (64-bit, non-prefetchable) [size=16M]
> 	Expansion ROM at c2000000 [disabled] [size=128K]
> 	Capabilities: [60] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [78] #10 [0001]

You may try to use 's2ram --force --vbe_post --vbe_mode', if you haven't tried
that already.

Still, if the card is a 7300 or higher, that need not work (at present we don't
know what magic is required to make these cards work).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
