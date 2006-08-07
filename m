From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Mon, 7 Aug 2006 08:31:30 +0400
Message-ID: <acd2a5930608062131i51320b45q1d169fd392ffe1b2@mail.gmail.com>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD018ACC7B@de01exm64.ds.mot.com>
	<200607241732.57588.david-b@pacbell.net>
	<1153822154.5875.16.camel@localhost>
	<200607252205.37086.david-b@pacbell.net>
	<8417055efd530dbc76993e0b1d61de81@nomadgs.com>
	<20060805120950.GB5417@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060805120950.GB5417@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: David Brownell <david-b@pacbell.net>, Preece Scott-PREECE <scott.preece@motorola.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> Thats more complex than it needs to be. Easy solution is to allways
> compile in full set from semiconductor vendor and then maybe only use
> subset.

Completely disagree.
That solution might be easy from a first glance, but you definitely
not seeing the whole picture.
Let's think a bit how it all should work from the embedded POV.
For a SoC, there can be different use cases, like GPS navigator,
GSM/GPRS phone, WiFi phone, MP3 player and so on. For EACH use case
(which is usually denoted as a 'policy'), there will be different sets
of devices enabled and sets of operating points valid for this use
case.
Given that the operating points are defined in kernel, how the
userspace application managing operating point transitions (power
management daemon) will work? The situation would be rather ridiculous
in this case: the description of valid OPs for a policy and OP
transitions will be separated from the description of OPs themselves,
and it would lead to a lot of redundant code and pretty unclear
overall structure.
So, the bottom line is: all OPs compiled in kernel and no runtime OPs
creation is the idea that is *orthogonal* to the dynamic power
management concept.
