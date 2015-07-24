From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 0/3] regmap: Use different lockdep class
 for each regmap init call
Date: Fri, 24 Jul 2015 11:32:47 +0100
Message-ID: <20150724103247.GG11162@sirena.org.uk>
References: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
 <CANMq1KD8rOHjtWA1Eiw9GATdTeq1Ch4bga4ZAty26auvWyX7Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9040278964220330294=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CANMq1KD8rOHjtWA1Eiw9GATdTeq1Ch4bga4ZAty26auvWyX7Og@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liviu Dudau <liviu.dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-pm@vger.kernel.org, Antti Palosaari <crope@iki.fi>, Zhang Rui <rui.zhang@intel.com>, Anatol Pomozov <anatol.pomozov@gmail.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>, Oder Chiou <oder_chiou@realtek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Ajit Pal Singh <ajitpal.singh@st.com>
List-Id: linux-pm@vger.kernel.org


--===============9040278964220330294==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cWQnRBNUz/XQASfL"
Content-Disposition: inline


--cWQnRBNUz/XQASfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 23, 2015 at 04:45:53PM +0800, Nicolas Boichat wrote:

> What's the status of this series (and the additional documentation
> fix: https://lkml.org/lkml/2015/7/8/385)?

> Do we need acks from the mfd/vexpress and thermal maintainers?
> (mfd/vexpress maintainers are Liviu Dudau, Sudeep Holla, and Lorenzo
> Pieralisi, I'm less clear about thermal, maybe Eduardo Valentin?)

Well, I was leaving it on the off chance someone would get round to
looking at it yes.  I might get bored at some point since it's just
mechanical changes outside of regmap.

--cWQnRBNUz/XQASfL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVshROAAoJECTWi3JdVIfQi+cH/3xKIYXsPgIvpmxhYmVqCRz/
4Bcd8mID1EUzlAB5LLgUOJBeQKUrhZ/4QEdIkyJa1ZK3wlb1LSM9PRNtBdtnZl1/
LTuKm2QdHz/kgybNCbTG6m9zM23UknN7icfm05PAqANzuN7nSm5Xqvkrc5GSpX9j
EzkEm6RkEvjsN047GMAtf1elpfv8SbfVnTM9Vcjlo6uPUUfVJIYGg6Rn7PYLxIul
MLBaYJ+MJdJJ05F+Vo3TDkQ5cUOxohQ8pUWn7PwAaPjg1ktaT45TmRRj6QswmC1m
J01ASYbHET1f7JQNyAb6kDKtpONerm6HKgfXDxPHE5j4gSJVNk1qiwmxd9hjND4=
=Gz38
-----END PGP SIGNATURE-----

--cWQnRBNUz/XQASfL--

--===============9040278964220330294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9040278964220330294==--
