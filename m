From: Pavel Machek <pavel@ucw.cz>
Subject: 2.6.14-rc1-mm1: usb breaks suspend
Date: Mon, 17 Oct 2005 12:01:34 +0200
Message-ID: <20051017100134.GA1764@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============14275276508241985=="
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
To: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============14275276508241985==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

In -mm, usb breaks suspend to disk. Compiled without
CONFIG_USB_SUSPEND, it just plainly fails; iwth USB_SUSPEND, it
actually tries to suspend USB, but it fails and machine refuses to
suspend. Is it known or is it worth debugging?
								Pavel
-- 
Thanks, Sharp!

--===============14275276508241985==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============14275276508241985==--
