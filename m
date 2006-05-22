From: David Brownell <david-b@pacbell.net>
Subject: Re: Ejecting/Powering off/ -> Turn off the device lamp.
Date: Mon, 22 May 2006 10:07:16 -0700
Message-ID: <200605221007.18175.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0605221238290.5806-100000@iolanthe.rowland.org>
	<4471EBC2.9000607@techmoninc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36993063385689778=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <4471EBC2.9000607@techmoninc.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Andy Kennedy <akennedy@techmoninc.com>
List-Id: linux-pm@vger.kernel.org

--===============36993063385689778==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 22 May 2006 9:50 am, Andy Kennedy wrote:

> I am working with an embedded system that will have no user interaction 
> save the USB port. ...
> 
> I have TTLs on the embedded system; I may just have to use those.

Sounds like you need to design in some additional user interaction,
either a LED driven by a GPIO to indicate "OK to remove", or else
a LED driven by that port's root hub.  (Some root hubs support the
standardized root hub LED mechanisms; most don't.)

- Dave


--===============36993063385689778==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36993063385689778==--
