From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: Powering down a device...
Date: Mon, 21 Nov 2005 14:26:10 -0800
Message-ID: <43824982.1070406@am.sony.com>
References: <EA12F909C0431D458B9D18A176BEE4A5030D5E61@dlee02.ent.ti.com>
	<1132536373.8816.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============14444991686885689=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1132536373.8816.34.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Percival <matthew@capgo.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============14444991686885689==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Matthew Percival wrote:

> 	I tried `standby', `mem' and `disc'
> with /sys/devices/platform/smc91x/power/state and saw no change; there
> was nothing printed on the terminal either. I guess it must not be
> implemented with this driver at the moment, which I guess is why there
> is no change when I put the whole system to sleep (please correct me if
> my assumptions are wrong).  If it is nothing too difficult to add to the
> driver, would you be able to direct me to where I may find out how to do
> this?

H. Kaminaga from Sony is maintaining some OSK 5912 PM support:

  http://lists.osdl.org/pipermail/linux-pm/2005-July/001077.html

-Geoff


--===============14444991686885689==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============14444991686885689==--
