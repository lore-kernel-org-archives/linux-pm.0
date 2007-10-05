From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: [linux-usb-devel] Fwd: USB suspending
Date: Fri, 5 Oct 2007 18:35:18 +0200
Message-ID: <20071005163518.GA2389__10402.7336267338$1191602694$gmane$org@ics.muni.cz>
References: <200710051559.43771.oliver@neukum.org>
	<Pine.LNX.4.44L0.0710051117560.4446-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0710051117560.4446-100000@iolanthe.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 05, 2007 at 11:25:11AM -0400, Alan Stern wrote:
> > But power consumption on these ports is minimal for suspended devices=
,
> > so it is a bad idea.
>=20
> Right.  Power consumption is even smaller on ports with no devices=20
> plugged in.

For example, IBM ThinkPad T60 powers off all USB ports when hcd-uhci modu=
le is
unloaded. My ASUS M6A does not, it does not also in Windows XP though.=20

I still wonder why suspended machine consumes about 2Wh in S-T-R while th=
e IBM
consumes about 0.2Wh.

--=20
Luk=E1=B9 Hejtm=E1nek
