From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sat, 17 Nov 2007 16:08:15 +0100
Message-ID: <473F03DF.4020306__23153.3332066194$1195312193$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0711161058170.2738-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0711161058170.2738-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 11/16/2007 05:10 PM, Alan Stern wrote:
> On Thu, 15 Nov 2007, Greg KH wrote:
>=20
>>> The offending -mm patch is
>>> gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch
>>>
>>> 2.6.24-rc2-mm1 minus it works just fine; PROVE_LOCKING shows nothing =
new when
>>> the patch is applied.
>> Thanks for tracking this down.  Alan, any thoughts?
>=20
> It's a driver problem somewhere.  Probably not one of the most common=20
> drivers because I don't see the same problem here (but then I'm not=20
> testing -mm).
>=20
> The thing to do is figure out which driver is causing the problem.
> Jiri, try enabling CONFIG_DEBUG_DRIVER. =20

Sadly no output.

> If there's also a config=20
> option to prevent the console from being suspended, set it as well. =20

no_suspend_console kernel parameter has no effect (why?).

> Then you should be able to tell which driver is making trouble.

I think no unusual hardware inside:

00:00.0 Host bridge: Intel Corporation 82G33/G31/P35 Express DRAM Control=
ler
(rev 02)
        Subsystem: Intel Corporation 82G33/G31/P35 Express DRAM Controlle=
r
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information
00: 86 80 c0 29 06 00 90 20 02 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 c0 29
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

00:02.0 VGA compatible controller: Intel Corporation 82G33/G31 Express
Integrated Graphics Controller (rev 02) (prog-if 00 [VGA])
        Subsystem: Intel Corporation 82G33/G31 Express Integrated Graphic=
s
Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at ffa80000 (32-bit, non-prefetchable) [size=3D5=
12K]
        Region 1: I/O ports at ec00 [size=3D8]
        Region 2: Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
        Region 3: Memory at ff900000 (32-bit, non-prefetchable) [size=3D1=
M]
        Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Que=
ue=3D0/0
Enable-
                Address: 00000000  Data: 0000
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 86 80 c2 29 07 00 90 00 02 00 00 03 00 00 00 00
10: 00 00 a8 ff 01 ec 00 00 08 00 00 d0 00 00 90 ff
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 c2 29
30: 00 00 00 00 90 00 00 00 00 00 00 00 0a 01 00 00

00:03.0 Communication controller: Intel Corporation 82G33/G31/P35 Express=
 MEI
Controller (rev 02)
        Subsystem: Intel Corporation 82G33/G31/P35 Express MEI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ffa7bc00 (64-bit, non-prefetchable) [size=3D1=
6]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [8c] Message Signalled Interrupts: Mask- 64bit+ Que=
ue=3D0/0
Enable-
                Address: 0000000000000000  Data: 0000
00: 86 80 c4 29 06 00 10 00 02 00 80 07 00 00 80 00
10: 04 bc a7 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 c4 29
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00

00:03.2 IDE interface: Intel Corporation 82G33/G31/P35 Express PT IDER
Controller (rev 02) (prog-if 85 [Master SecO PriO])
        Subsystem: Intel Corporation 82G33/G31/P35 Express PT IDER Contro=
ller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 12
        Region 0: I/O ports at e880 [size=3D8]
        Region 1: I/O ports at e800 [size=3D4]
        Region 2: I/O ports at e480 [size=3D8]
        Region 3: I/O ports at e400 [size=3D4]
        Region 4: I/O ports at e080 [size=3D16]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Que=
ue=3D0/0
Enable-
                Address: 0000000000000000  Data: 0000
00: 86 80 c6 29 05 00 b0 00 02 85 01 01 00 00 00 00
10: 81 e8 00 00 01 e8 00 00 81 e4 00 00 01 e4 00 00
20: 81 e0 00 00 00 00 00 00 00 00 00 00 86 80 c6 29
30: 00 00 00 00 c8 00 00 00 00 00 00 00 0c 03 00 00

00:03.3 Serial controller: Intel Corporation 82G33/G31/P35 Express Serial=
 KT
Controller (rev 02) (prog-if 02 [16550])
        Subsystem: Intel Corporation 82G33/G31/P35 Express Serial KT Cont=
roller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at e000 [size=3D8]
        Region 1: Memory at ffa7a000 (32-bit, non-prefetchable) [size=3D4=
K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Que=
ue=3D0/0
Enable-
                Address: 0000000000000000  Data: 0000
00: 86 80 c7 29 07 00 b0 00 02 02 00 07 00 00 00 00
10: 01 e0 00 00 00 a0 a7 ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 c7 29
30: 00 00 00 00 c8 00 00 00 00 00 00 00 05 02 00 00

00:19.0 Ethernet controller: Intel Corporation 82566DM-2 Gigabit Network
Connection (rev 02)
        Subsystem: Intel Corporation Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 318
        Region 0: Memory at ffa40000 (32-bit, non-prefetchable) [size=3D1=
28K]
        Region 1: Memory at ffa79000 (32-bit, non-prefetchable) [size=3D4=
K]
        Region 2: I/O ports at dc00 [size=3D32]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Que=
ue=3D0/0
Enable+
                Address: 00000000fee0300c  Data: 4191
        Capabilities: [e0] Vendor Specific Information
00: 86 80 bd 10 07 04 10 00 02 00 00 02 00 00 00 00
10: 00 00 a4 ff 00 90 a7 ff 01 dc 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
30: 00 00 00 00 c8 00 00 00 00 00 00 00 0f 01 00 00

00:1a.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801I (ICH9 Family) USB UHCI Contro=
ller #4
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at d880 [size=3D32]
        Capabilities: [50] Vendor Specific Information
00: 86 80 37 29 05 00 90 02 02 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 d8 00 00 00 00 00 00 00 00 00 00 86 80 37 29
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00

00:1a.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #5 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801I (ICH9 Family) USB UHCI Contro=
ller #5
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at d800 [size=3D32]
        Capabilities: [50] Vendor Specific Information
00: 86 80 38 29 05 00 90 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 86 80 38 29
30: 00 00 00 00 50 00 00 00 00 00 00 00 0e 02 00 00

00:1a.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #6 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801I (ICH9 Family) USB UHCI Contro=
ller #6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at d480 [size=3D32]
        Capabilities: [50] Vendor Specific Information
00: 86 80 39 29 05 00 90 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 d4 00 00 00 00 00 00 00 00 00 00 86 80 39 29
30: 00 00 00 00 50 00 00 00 00 00 00 00 0c 03 00 00

00:1a.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI
Controller #2 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Contr=
oller #2
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at ffa7b400 (32-bit, non-prefetchable) [size=3D1=
K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [58] Debug port
        Capabilities: [98] Vendor Specific Information
00: 86 80 3c 29 06 00 90 02 02 20 03 0c 00 00 00 00
10: 00 b4 a7 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 3c 29
30: 00 00 00 00 50 00 00 00 00 00 00 00 03 04 00 00

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Con=
troller
(rev 02)
        Subsystem: Intel Corporation 82801I (ICH9 Family) HD Audio Contro=
ller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at ffa70000 (64-bit, non-prefetchable) [size=3D1=
6K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Que=
ue=3D0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, Ext=
Tag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown, Po=
rt 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)
00: 86 80 3e 29 06 00 10 00 02 00 03 04 08 00 00 00
10: 04 00 a7 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 3e 29
30: 00 00 00 00 50 00 00 00 00 00 00 00 07 01 00 00

00:1d.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801I (ICH9 Family) USB UHCI Contro=
ller #1
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 4: I/O ports at d400 [size=3D32]
        Capabilities: [50] Vendor Specific Information
00: 86 80 34 29 05 00 90 02 02 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 86 80 34 29
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00

00:1d.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801I (ICH9 Family) USB UHCI Contro=
ller #2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at d080 [size=3D32]
        Capabilities: [50] Vendor Specific Information
00: 86 80 35 29 05 00 90 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 d0 00 00 00 00 00 00 00 00 00 00 86 80 35 29
30: 00 00 00 00 50 00 00 00 00 00 00 00 03 02 00 00

00:1d.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801I (ICH9 Family) USB UHCI Contro=
ller #3
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 16
        Region 4: I/O ports at d000 [size=3D32]
        Capabilities: [50] Vendor Specific Information
00: 86 80 36 29 05 00 90 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 86 80 36 29
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 04 00 00

00:1d.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI
Controller #1 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Contr=
oller #1
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at ffa7b000 (32-bit, non-prefetchable) [size=3D1=
K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [58] Debug port
        Capabilities: [98] Vendor Specific Information
00: 86 80 3a 29 06 00 90 02 02 20 03 0c 00 00 00 00
10: 00 b0 a7 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 3a 29
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92) (prog-if =
01
[Subtractive decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
32
        Memory behind bridge: ff600000-ff6fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Subsystem: Intel Corporation 82801 PCI Bridge
00: 86 80 4e 24 06 01 10 00 92 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 f0 00 80 22
20: 60 ff 60 ff f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 02 00

00:1f.0 ISA bridge: Intel Corporation Unknown device 2910 (rev 02)
        Subsystem: Intel Corporation Unknown device 2910
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information
00: 86 80 10 29 07 00 10 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 10 29
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 =
port
SATA AHCI Controller (rev 02) (prog-if 01 [AHCI 1.0])
        Subsystem: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port S=
ATA
AHCI Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 319
        Region 0: I/O ports at cc00 [size=3D8]
        Region 1: I/O ports at c880 [size=3D4]
        Region 2: I/O ports at c800 [size=3D8]
        Region 3: I/O ports at c480 [size=3D4]
        Region 4: I/O ports at c400 [size=3D32]
        Region 5: Memory at ffa78800 (32-bit, non-prefetchable) [size=3D2=
K]
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Que=
ue=3D0/4
Enable+
                Address: fee0300c  Data: 4169
        Capabilities: [70] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [a8] #12 [0010]
        Capabilities: [b0] Vendor Specific Information
00: 86 80 22 29 07 04 b0 02 02 01 06 01 00 00 00 00
10: 01 cc 00 00 81 c8 00 00 01 c8 00 00 81 c4 00 00
20: 01 c4 00 00 00 88 a7 ff 00 00 00 00 86 80 22 29
30: 00 00 00 00 80 00 00 00 00 00 00 00 03 02 00 00

00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (r=
ev 02)
        Subsystem: Intel Corporation 82801I (ICH9 Family) SMBus Controlle=
r
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 18
        Region 0: Memory at ffa7b800 (64-bit, non-prefetchable) [size=3D2=
56]
        Region 4: I/O ports at 0400 [size=3D32]
00: 86 80 30 29 03 00 80 02 02 00 05 0c 00 00 00 00
10: 04 b8 a7 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 04 00 00 00 00 00 00 00 00 00 00 86 80 30 29
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 03 00 00

00:1f.5 IDE interface: Intel Corporation 82801I (ICH9 Family) 2 port SATA=
 IDE
Controller (rev 02) (prog-if 85 [Master SecO PriO])
        Subsystem: Intel Corporation 82801I (ICH9 Family) 2 port SATA IDE=
 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at c000 [size=3D8]
        Region 1: I/O ports at bc00 [size=3D4]
        Region 2: I/O ports at b880 [size=3D8]
        Region 3: I/O ports at b800 [size=3D4]
        Region 4: I/O ports at b480 [size=3D16]
        Region 5: I/O ports at b400 [size=3D16]
        Capabilities: [70] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [b0] Vendor Specific Information
00: 86 80 26 29 07 00 b0 02 02 85 01 01 00 00 00 00
10: 01 c0 00 00 01 bc 00 00 81 b8 00 00 01 b8 00 00
20: 81 b4 00 00 01 b4 00 00 00 00 00 00 86 80 26 29
30: 00 00 00 00 70 00 00 00 00 00 00 00 03 02 00 00

00:1f.6 Signal processing controller: Intel Corporation 82801I (ICH9 Fami=
ly)
Thermal Subsystem (rev 02)
        Subsystem: Intel Corporation 82801I (ICH9 Family) Thermal Subsyst=
em
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort-
<MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 12
        Region 0: Memory at ffa6f000 (64-bit, non-prefetchable) [size=3D4=
K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 86 80 32 29 02 00 10 00 02 00 80 11 00 00 00 00
10: 04 f0 a6 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 32 29
30: 00 00 00 00 50 00 00 00 00 00 00 00 0c 03 00 00

01:00.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11ab=
g NIC
(rev 01)
        Subsystem: Wistron NeWeb Corp. CM9 Wireless a/b/g MiniPCI Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParEr=
r-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168 (2500ns min, 7000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at ff6f0000 (32-bit, non-prefetchable) [size=3D6=
4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-
00: 8c 16 13 00 16 00 90 02 01 00 00 02 08 a8 00 00
10: 00 00 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 01 50 00 00 5f 18 12 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 0e 01 0a 1c






Plugged usb devices:

Bus 004 Device 007: ID 045e:00f0 Microsoft Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x045e Microsoft Corp.
  idProduct          0x00f0
  bcdDevice            1.01
  iManufacturer           1 Microsoft Corporation
  iProduct                2 Microsoft =EF=BF=BD Laser Mouse 6000
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode           33 US
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      59
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              10

Bus 004 Device 006: ID 0458:004c KYE Systems Corp. (Mouse Systems) Slimst=
ar Pro
Keyboard
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0458 KYE Systems Corp. (Mouse Systems)
  idProduct          0x004c Slimstar Pro Keyboard
  bcdDevice            1.01
  iManufacturer           1 ABBHOME
  iProduct                2 USB Keyboard
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower               50mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      65
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     104
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10

Bus 004 Device 005: ID 04b4:2050 Cypress Semiconductor Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0         8
  idVendor           0x04b4 Cypress Semiconductor Corp.
  idProduct          0x2050
  bcdDevice            0.01
  iManufacturer           1 Bella Corporation
  iProduct                2 GBella Corporation DV Keyboard
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             3
  wHubCharacteristic 0x000d
    Per-port power switching
    Compound device
    Per-port overcurrent protection
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent     25 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x60
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0303 lowspeed power enable connect
   Port 3: 0000.0100 power

regards,
--=20
Jiri Slaby (jirislaby@gmail.com)
Faculty of Informatics, Masaryk University
