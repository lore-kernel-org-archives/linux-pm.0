From: "Martin, LoicX" <loicx.martin@intel.com>
Subject: suspend() and runtime_suspend()
Date: Mon, 21 Mar 2011 09:10:48 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188142FF8486@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2316395195169736424=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============2316395195169736424==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_9F3EABD6E3419B4C81F34EAABB4D40188142FF8486irsmsx501gerc_"

--_000_9F3EABD6E3419B4C81F34EAABB4D40188142FF8486irsmsx501gerc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi

I found in the linux kernel documentation :
In /power/pci.h
2.4.1. System Suspend

PCI device drivers (that don't implement legacy power management callbacks)=
 are
generally not expected to prepare devices for signaling wakeup or to put th=
em
into low-power states.  However, if one of the driver's suspend callbacks
(pm->suspend() or pm->suspend_noirq()) saves the device's standard configur=
ation
registers, pci_pm_suspend_noirq() will assume that the device has been prep=
ared
to signal wakeup and put into a low-power state by the driver (the driver is
then assumed to have used the helper functions provided by the PCI subsyste=
m for
this purpose).  PCI device drivers are not encouraged to do that, but in so=
me
rare cases doing that in the driver may be the optimum approach.

3.1.2 suspend()

It is not required (in fact it even is
not recommended) that a PCI driver's suspend() callback save the standard
configuration registers of the device, prepare it for waking up the system,=
 or
put it into a low-power state.  All of these operations can very well be ta=
ken
care of by the PCI subsystem, without the driver's participation.

2.3. Runtime Device Power Management

It is expected that the device driver's pm->runtime_suspend() callback will
not attempt to prepare the device for signaling wakeup or to put it into a
low-power state.  The driver ought to leave these tasks to the PCI subsystem
that has all of the information necessary to perform them.


So I was wondering why in the kernel sources, most of the PCI drivers were =
using pci_set_power_state, as well pci_save_state either in suspend() callb=
acks either in runtime_suspend() callbacks.
Why should we not use those functions in a driver suspend callback implemen=
tation ?

Thx

Loic


---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris,=20
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--_000_9F3EABD6E3419B4C81F34EAABB4D40188142FF8486irsmsx501gerc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 12">
<meta name=3DOriginator content=3D"Microsoft Word 12">
<link rel=3DFile-List href=3D"cid:filelist.xml@01CBE7B0.3FF0B0F0">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
  <o:TargetScreenSize>1024x768</o:TargetScreenSize>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:HyphenationZone>21</w:HyphenationZone>
  <w:EnvelopeVis/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>FR</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:DontVertAlignCellWithSp/>
   <w:DontBreakConstrainedForcedTables/>
   <w:DontVertAlignInTxbx/>
   <w:Word11KerningPairs/>
   <w:CachedColBalance/>
  </w:Compatibility>
  <m:mathPr>
   <m:mathFont m:val=3D"Cambria Math"/>
   <m:brkBin m:val=3D"before"/>
   <m:brkBinSub m:val=3D"&#45;-"/>
   <m:smallFrac m:val=3D"off"/>
   <m:dispDef/>
   <m:lMargin m:val=3D"0"/>
   <m:rMargin m:val=3D"0"/>
   <m:defJc m:val=3D"centerGroup"/>
   <m:wrapIndent m:val=3D"1440"/>
   <m:intLim m:val=3D"subSup"/>
   <m:naryLim m:val=3D"undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" DefUnhideWhenUsed=3D"true"=20
  DefSemiHidden=3D"true" DefQFormat=3D"false" DefPriority=3D"99"=20
  LatentStyleCount=3D"267">
  <w:LsdException Locked=3D"false" Priority=3D"0" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Normal"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"heading 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"=
heading 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"=
heading 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"=
heading 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"=
heading 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"=
heading 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"=
heading 7"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"=
heading 8"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"=
heading 9"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 7"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 8"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 9"/>
  <w:LsdException Locked=3D"false" Priority=3D"35" QFormat=3D"true" Name=3D=
"caption"/>
  <w:LsdException Locked=3D"false" Priority=3D"10" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Title"/>
  <w:LsdException Locked=3D"false" Priority=3D"1" Name=3D"Default Paragraph=
 Font"/>
  <w:LsdException Locked=3D"false" Priority=3D"11" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtitle"/>
  <w:LsdException Locked=3D"false" Priority=3D"22" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Strong"/>
  <w:LsdException Locked=3D"false" Priority=3D"20" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Emphasis"/>
  <w:LsdException Locked=3D"false" Priority=3D"59" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Table Grid"/>
  <w:LsdException Locked=3D"false" UnhideWhenUsed=3D"false" Name=3D"Placeho=
lder Text"/>
  <w:LsdException Locked=3D"false" Priority=3D"1" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"No Spacing"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Shading"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light List"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Grid"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Dark List"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful List"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 1"/>
  <w:LsdException Locked=3D"false" UnhideWhenUsed=3D"false" Name=3D"Revisio=
n"/>
  <w:LsdException Locked=3D"false" Priority=3D"34" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"List Paragraph"/>
  <w:LsdException Locked=3D"false" Priority=3D"29" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Quote"/>
  <w:LsdException Locked=3D"false" Priority=3D"30" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Quote"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"19" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtle Emphasis"/>
  <w:LsdException Locked=3D"false" Priority=3D"21" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Emphasis"/>
  <w:LsdException Locked=3D"false" Priority=3D"31" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtle Reference"/>
  <w:LsdException Locked=3D"false" Priority=3D"32" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Reference"/>
  <w:LsdException Locked=3D"false" Priority=3D"33" SemiHidden=3D"false"=20
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Book Title"/>
  <w:LsdException Locked=3D"false" Priority=3D"37" Name=3D"Bibliography"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" QFormat=3D"true" Name=3D=
"TOC Heading"/>
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-alt:"Calisto MT";
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-1610611985 1107304683 0 0 415 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-alt:Hercules;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;
	mso-header-margin:36.0pt;
	mso-footer-margin:36.0pt;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-qformat:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	mso-fareast-language:EN-US;}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DFR link=3Dblue vlink=3Dpurple style=3D'tab-interval:35.4pt'>

<div class=3DWordSection1>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'>H=
i<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'><=
o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'>I=
 found in
the <span class=3DSpellE>linux</span> kernel documentation&nbsp;:<o:p></o:p=
></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'>I=
n /power/<span
class=3DSpellE>pci.h</span><o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'>2=
.4.1.
System Suspend<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'><=
o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>PCI device drivers (that don't implement =
legacy
power management callbacks) are<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>generally not expected to prepare devices=
 for
signaling wakeup or to put them<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>into low-power states.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>However, if one of the driver's su=
spend
callbacks<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>(pm-&gt;suspend() or pm-&gt;<span class=
=3DSpellE>suspend_noirq</span>())
saves the device's standard configuration<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>registers, <span class=3DSpellE>pci_pm_su=
spend_noirq</span>()
will assume that the device has been prepared<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>to signal <span class=3DSpellE>wakeup</sp=
an> and put
into a low-power state by the driver (the driver is<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>then assumed to have used the helper func=
tions
provided by the PCI subsystem for<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>this purpose).<span style=3D'mso-spacerun=
:yes'>&nbsp;
</span>PCI device drivers are not encouraged to do that, but in some<o:p></=
o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>rare cases doing that in the driver may b=
e the
optimum approach. <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'>3=
.1.2
suspend()<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'><=
o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>It is not required (in fact it even is<o:=
p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>not recommended) that a PCI driver's susp=
end()
callback save the standard<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>configuration registers of the device, pr=
epare
it for waking up the system, or<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>put it into a low-power state.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>All of these operations can very w=
ell be
taken<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>care of by the PCI subsystem, without the
driver's participation.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'><=
o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'>2=
.3.
Runtime Device Power Management<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'><=
o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>It is expected that the device driver's p=
m-&gt;<span
class=3DSpellE>runtime_suspend</span>() callback will<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>not attempt to prepare the device for sig=
naling
wakeup or to put it into a<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>low-power state.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>The driver ought to leave these ta=
sks to the
PCI subsystem<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:35.4pt'><span lang=3DEN-US
style=3D'mso-ansi-language:EN-US'>that has all of the information necessary=
 to
perform them.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'><=
o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'><=
o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-ansi-language:EN-US'>S=
o I was
wondering why in the kernel sources, most of the PCI drivers were using <sp=
an
class=3DSpellE>pci_set_power_state</span>, as well <span class=3DSpellE>pci=
_save_state</span>
either in suspend() callbacks either in <span class=3DSpellE>runtime_suspen=
d</span>()
callbacks.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-fareast-font-family:"T=
imes New Roman";
color:black;mso-ansi-language:EN-US;mso-fareast-language:FR;mso-no-proof:ye=
s'>Why
should we not use those functions in a driver suspend callback implementati=
on ?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-fareast-font-family:"T=
imes New Roman";
color:black;mso-ansi-language:EN-US;mso-fareast-language:FR;mso-no-proof:ye=
s'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-fareast-font-family:"T=
imes New Roman";
color:black;mso-ansi-language:EN-US;mso-fareast-language:FR;mso-no-proof:ye=
s'>Thx<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-fareast-font-family:"T=
imes New Roman";
color:black;mso-ansi-language:EN-US;mso-fareast-language:FR;mso-no-proof:ye=
s'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'mso-fareast-font-family:"T=
imes New Roman";
color:black;mso-ansi-language:EN-US;mso-fareast-language:FR;mso-no-proof:ye=
s'>Loic<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'mso-fareast-font-family:"Times New Roma=
n";
mso-fareast-language:FR;mso-no-proof:yes'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<font face=3D"monospace">--------------------------------------------------=
-------------------<br>
Intel Corporation SAS (French simplified joint stock company)<br>
Registered headquarters: "Les Montalets"- 2, rue de Paris, <br>
92196 Meudon Cedex, France<br>
Registration Number:&nbsp; 302 456 199 R.C.S. NANTERRE<br>
Capital: 4,572,000 Euros<br>
<br>
This e-mail and any attachments may contain confidential material for<br>
the sole use of the intended recipient(s). Any review or distribution<br>
by others is strictly prohibited. If you are not the intended<br>
recipient, please contact the sender and delete all copies.</font></body>

</html>

--_000_9F3EABD6E3419B4C81F34EAABB4D40188142FF8486irsmsx501gerc_--


--===============2316395195169736424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2316395195169736424==--
