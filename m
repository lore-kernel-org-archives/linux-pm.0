From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: Research on device power management
Date: Fri, 28 Oct 2005 12:36:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510281233390.4862-100000@iolanthe.rowland.org>
References: <F760B14C9561B941B89469F59BA3A8470BADB1BD@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============90950255584191642=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470BADB1BD@orsmsx401.amr.corp.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Gross, Mark" <mark.gross@intel.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============90950255584191642==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 28 Oct 2005, Gross, Mark wrote:

> Also, I would be interested in USB mouse and wireless mouse effects on
> the system.  I know low speed usb devices result in a PCI interrupt
> every msec,

No they don't.  Interrupts occur only when data is transferred.

On the other hand, connecting USB devices (of any speed) causes ongoing
DMA activity, which can prevent CPUs from entering their most power-saving 
states.

Alan Stern


--===============90950255584191642==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============90950255584191642==--
