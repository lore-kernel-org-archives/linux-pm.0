From: Matthew Percival <matthew@capgo.com>
Subject: Powering down a device...
Date: Mon, 21 Nov 2005 09:44:45 +1100
Message-ID: <1132526685.8816.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89944817121302445=="
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

--===============89944817121302445==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

G'Day,

	I was directed here from the linux-omap-open-source mailing list.

	I am using an OMAP5912, and have been looking at what power savings I
get when using Deep Sleep (echo -n "standby" > /sys/power/state), and
noticed that there is no change in vmain.  I am hoping that turning the
Ethernet controller off before entering deep sleep will make a
significant difference, but I do not know how to do this.

	If I look in drivers/net/smc91x.c, there is already a suspend function
written, which apparently powers the device down.  I do not believe this
is currently being used anywhere, and I am not sure how exactly it is
supposed to be used to begin with.  I was hoping that someone here would
be able to give me some information on using device_driver->suspend()
functions.

	As an aside, is there anyone here who knows how to use Big Sleep in an
OMAP environment?  I have worked out how to configure it, but not how to
enter it.  As this is not an OMAP mailing list, I am not expecting
anyone here to know the answer to that one, but it cannot hurt to ask.

	Thanks for your time,

	Matthew


--===============89944817121302445==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89944817121302445==--
