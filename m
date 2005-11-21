From: Matthew Percival <matthew@capgo.com>
Subject: RE: Powering down a device...
Date: Mon, 21 Nov 2005 12:26:13 +1100
Message-ID: <1132536373.8816.34.camel@localhost.localdomain>
References: <EA12F909C0431D458B9D18A176BEE4A5030D5E61@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79793471778186276=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5030D5E61@dlee02.ent.ti.com>
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

--===============79793471778186276==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

G'Day,

	Thanks for your reply.  I have tried your suggestions out, but have not
been able to conserve any additional power.

> For device sleeps you just do an 'echo mem > /sys/power/state'.  Pm.c
> will map which sleep and wake this takes you to.

	I just tried comparing `standby' with `mem', and there was no
difference in vmain --- or anywhere else for that matter, though I was
no expecting to see any change elsewhere.

> Each individual device will also have a power/state file in the sysfs
> directory structure.  You can echo a device power state down to the
> driver and it will react how if it knows how to enter that state.

	I tried `standby', `mem' and `disc'
with /sys/devices/platform/smc91x/power/state and saw no change; there
was nothing printed on the terminal either. I guess it must not be
implemented with this driver at the moment, which I guess is why there
is no change when I put the whole system to sleep (please correct me if
my assumptions are wrong).  If it is nothing too difficult to add to the
driver, would you be able to direct me to where I may find out how to do
this?

> Also, in sleeps where you want a good effect, you will need to configure
> the external pins to the optimal sleep state.  Any floating inputs will
> consume a lot of power.... how you drive the pin states really depends
> on what it is connected to.

	That sounds like a rather good tip, thanks!

	-- Matthew


--===============79793471778186276==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79793471778186276==--
