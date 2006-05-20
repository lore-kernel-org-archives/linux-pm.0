From: David Brownell <david-b@pacbell.net>
Subject: Re: suspend and hibernate nomenclature
Date: Sat, 20 May 2006 13:47:25 -0700
Message-ID: <200605201347.27957.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0605201520140.29313-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============98441579990576589=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0605201520140.29313-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org, richard@hughsie.com, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============98441579990576589==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 20 May 2006 12:23 pm, Alan Stern wrote:
> On Sat, 20 May 2006, Pavel Machek wrote:
> 
> > > > > As for downloading, that's why ethernet adapters have wake-on-lan (WOL)
> > > > > mechanisms.  Likewise for other wakeup-capable devices, like a keyboard
> > > > > or mouse.  Or even 3D engines, DSPs, SPUs, ...
> > > > 
> > > > ?? WOL is for different functionality, I'm afraid. Or do you know
> > > > ethernet hub that automagically wakes machines when data come?
> > > 
> > > No, that's exactly what WOL is designed for.  A typical scenarios has
> > > the adapter waking up when the incoming packet is unicast to the MAC
> > > address of that host.  The hub/switch would act normally.
> > 
> > I do not think WOL wakes that way. IIRC it needs magic ethernet
> > packet.
> 
> That's right.  I don't remember what the contents need to be, but WOL 
> doesn't work with any old ethernet packet.

You're both wrong.  Notice what "man ethtool" reports:

       wol p|u|m|b|a|g|s|d...
              Set Wake-on-LAN options.  Not all devices support this.  The argument to this
              option is a string of characters specifying which options to enable.

              p  Wake on phy activity
              u  Wake on unicast messages
              m  Wake on multicast messages
              b  Wake on broadcast messages
              a  Wake on ARP
              g  Wake on MagicPacket(tm)
              s  Enable SecureOn(tm) password for MagicPacket(tm)
              d  Disable (wake on nothing).  This option clears all previous options.

It does not "need" MagicPacket; not all hardware supports it.  On hardware that
does support it, you aren't forced to use it.  (MagicPacket is nice for certain
kinds of remote administration.)

A brief survey of some Ethernet-equipped Linux hardware I see right now:

 - RTL 8139, supports pumbg
 - SIS 900, supports pg
 - at91rm9200 (arm920), supports pumb (in hardware, from "standby", but
   its Linux driver doesn't handle it yet)


> You can see this by looking closely at what Dave wrote: "... the incoming
> packet is unicast to the MAC address of that host."  If the host has been
> asleep for some time, its MAC address will have timed out from the
> source's ARP cache.  The source will need to broadcast an ARP request
> packet before it can unicast anything, and the broadcast won't wake up the 
> host.

Well, controllers may wake on ARP too.  And if a download is active, then
it's likely that the ARP cache won't be timing out ... and even if it did
time out, some networks use proxy ARP or persisten ARP cache entries, so
using ARP is not always necessary.

Point being as I said:  that WOL helps address that problem.  As always,
if you need particular hardware capabilities (like wake-on-unicast) you
need to make sure your hardware has them.

- Dave


--===============98441579990576589==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============98441579990576589==--
