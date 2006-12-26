From: Alan Stern <stern@rowland.harvard.edu>
Subject: USB power usage
Date: Mon, 25 Dec 2006 22:53:32 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0612252245310.29662-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Dec. 22, 2006 Pavel Machek wrote:

> Couple of watts is not that bad, considering usb still eats 4W more
> than it should.

The USB autosuspend mechanism has been present for a while in -mm and is
included in 2.6.20-rc (although you have to turn on CONFIG_USB_SUSPEND,
which is off by default -- it would be nice to change that).  Has anybody
tried doing some real-world measurements to see if it actually makes a
significant improvement in power usage?

Alan Stern
