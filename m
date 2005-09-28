From: David Brownell <david-b@pacbell.net>
Subject: Fwd: [patch 2.6.14-rc1, 0/5] USB PM updates
Date: Wed, 28 Sep 2005 09:25:57 -0700
Message-ID: <200509280925.57446.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82252312965420005=="
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============82252312965420005==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This batch of stuff is in 2.6.14-rc2-mm1 already.

----------  Forwarded Message  ----------

Subject: [patch 2.6.14-rc1, 0/5] USB PM updates
Date: Tuesday 13 September 2005 7:56 pm
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Cc: Greg KH <greg@kroah.com>

The next five patches are small incremental steps that shrink
the difference between configurations with CONFIG_USB_SUSPEND
enabled, and those without it.  There will be other such steps,
since eventually we want that config option to vanish.

  pm-ifstate.patch ... tightens "interface power state" handling
  pm-ifsusp.patch ... removes recursion from hub and device suspend()
  pm-usbsusp.patch ... removes usb_suspend_device() parameter
  pm-x-resume.patch ... removes some duplicated resume path code
  pm-config.patch ... removes some uses of CONFIG_USB_SUSPEND

Yes, a net code shrink here.  That last patch is independent of
the others, but the first four need to be applied in order.

- Dave



-------------------------------------------------------

--===============82252312965420005==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============82252312965420005==--
