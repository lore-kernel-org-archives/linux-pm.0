From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Disabling Devices
Date: Mon, 9 May 2005 09:51:58 -0700
Message-ID: <200505090951.59037.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0505091124370.5325-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============53092047813252741=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0505091124370.5325-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============53092047813252741==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 09 May 2005 8:37 am, Alan Stern wrote:

> As for the remains of previously-removed hardware -- I shouldn't think it 
> matters very much what anybody tries to do to a piece of hardware, once 
> that hardware has been removed from the system!

Depends on the hardware.  Maybe it's a silent failure (as with
CardBus reads returning all ones); or a message passing error that
the driver sees; or maybe the lack of handshake means a bus error
gets generated, and the driver oopses.  That last is unfriendly,
enough so that I think nobody would design a "hotpluggable" bus
where hardware behaves like that.

- Dave


--===============53092047813252741==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============53092047813252741==--
