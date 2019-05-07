From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] cpufreq: imx6q: Fix the resource leak caused by
 incorrect error return
Date: Tue, 7 May 2019 08:07:02 +0200
Message-ID: <20190507060702.ub4zjsurylldj2mm@pengutronix.de>
References: <20190505080736.27970-1-ping.bai@nxp.com>
 <20190507055327.sakuoy2j3g7dwv3f@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190507055327.sakuoy2j3g7dwv3f@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jacky Bai <ping.bai@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 07, 2019 at 11:23:27AM +0530, Viresh Kumar wrote:
> On 05-05-19, 08:02, Jacky Bai wrote:
> > Previous goto only handled the node reference, the opp table,
> > regulator & clk resource also need to be free before error return.
> > =

> > Fixes: ddb64c5db3c (cpufreq: imx6q: fix possible object reference leak).
> =

> This should have been.
> =

> Fixes: ddb64c5db3cc ("cpufreq: imx6q: fix possible object reference leak")
> =

> Auto configure it with following in .gitconfig
> =

> [pretty]
> 	fixes =3D Fixes: %h (\"%s\")
> 	onelin =3D commit %h (\"%s\")
> =

> and then:
> =

> git log --pretty=3Dfixes ddb64c5db3c
> =

> will generate it by itself.

Just to add my color of the bikeshed, I have (among others):

[alias]
	oneq =3D show -s --pretty=3D'format:%h (\"%s\")'

in my ~/.gitconfig and can do:

$ git oneq ddb64c5db3c
ddb64c5db3cc ("cpufreq: imx6q: fix possible object reference leak")

which is a bit shorter than Viresh's suggestion.

(Originally I had "one" without the quotes which I learned (IIRC) from
the git mailing list. Instead of deviating from this I added 'q' for
"quotes" to match the usual convention in kernel land.)

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
