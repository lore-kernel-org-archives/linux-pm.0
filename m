From: Igor Gnatenko <i.gnatenko.brain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [REGRESSION] iwlfiwi with Intel Centrino N1000 won't work with
 power_save
Date: Wed, 14 Jan 2015 11:40:18 +0300
Message-ID: <1421224818.2012.4.camel@gmail.com>
References: <1421224274.2012.2.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-igDySlFRcnmfR7Ew40dR"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421224274.2012.2.camel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Wysocki, Rafael" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alex Nik <rage.iz.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--=-igDySlFRcnmfR7Ew40dR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2015-01-14 at 11:31 +0300, Igor Gnatenko wrote:
> Hi,
>=20
> I got report from people that on Intel Centrino N1000 wifi won't=20
> work after
> updating to 3.17.8. I see in that release Fedora maints enabled=20
> POWERCAP and
> INTEL RAPL. We got working wifi only after disabling powersave via=20
> `iw dev wlp2s0 set power_save off`.
>=20
> How we can debug this?
>=20
> lspci above.
>=20
> 02:00.0 Network controller [0280]: Intel Corporation Centrino=20
> Wireless- N 1000 [Condor Peak] [8086:0084]
>         Subsystem: Intel Corporation Centrino Wireless-N 1000 BGN
> [8086:1315]
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast=20
> >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 28
>         Region 0: Memory at d1500000 (64-bit, non-prefetchable)
> [size=3D8K]
>         Capabilities: [c8] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
> PME(D0+,D1-
> ,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0=20
> PME-
>         Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>                 Address: 00000000fee0800c  Data: 4122
>         Capabilities: [e0] Express (v1) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency=20
> L0s
> <512ns, L1 unlimited
>                 ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                 RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>                 MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s=20
> L1,
> Exit Latency L0s <128ns, L1 <32us
>                 ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled-=20
> CommClk+
>                 ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap- CGenEn-
> ChkCap- ChkEn-
>         Capabilities: [140 v1] Device Serial Number 74-e5-0b-ff-ff-
> cc-
> 82-24
>         Kernel driver in use: iwlwifi
>         Kernel modules: iwlwifi
> --
> -Igor Gnatenko
CC linux-pm@
--=20
-Igor Gnatenko
--=-igDySlFRcnmfR7Ew40dR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUtityAAoJEGmy9zExMnyPrxkH/i/qwLf400p7IH/AeYKdv2cf
WqFMS+otRs+urkKlT4sagbxCumxmoyw2Ay66sywDrjLO075PMSVKr2aqGXXP/zTG
o4OakEY9Jn5FwbLY04r5qSXFMFDh/jeI7QvLHz0MaDkBuFQaaIg6uGbI383ubKb2
lLThaEiKY1t8CcF+O0g00SpBPLKf0FKmd0+Gaz2c5xMAKY5hfzhzmtdHQe3YEJsz
BsJQuOQOmW3eyiL2DMRfrX2kuf7JblotUo0rR4JSCCJDdzerf2EO9uT3tw7RCWkD
Yaa5FbIDKN0jHkx10oghOwB1o4/a6zmNDo/Qvk3BFZtbY0JMIV+si1IblVCh378=
=ZgoJ
-----END PGP SIGNATURE-----

--=-igDySlFRcnmfR7Ew40dR--

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
