From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/7] cpufreq: Register cooling device after policy is usable
Date: Thu, 27 Nov 2014 01:26:36 +0100
Message-ID: <1985055.vMegQrvuv6@vostro.rjw.lan>
References: <cover.1416980447.git.viresh.kumar@linaro.org> <20141126175429.GA1826@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52887 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751659AbaK0AFU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 19:05:20 -0500
In-Reply-To: <20141126175429.GA1826@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com

On Wednesday, November 26, 2014 01:54:31 PM Eduardo Valentin wrote:
> 
> --UugvWAfsgieZRqgk
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> Hello Viresh,
> 
> Thanks for providing a proposal.
> 
> On Wed, Nov 26, 2014 at 11:22:55AM +0530, Viresh Kumar wrote:
> > Hi Rafael/Eduardo,
> >=20
> > Currently there is no callback for cpufreq drivers which is called once t=
> he
> > policy is ready to be used. There are some requirements where such a call=
> back is
> > required.
> >=20
> > One of them is registering a cooling device with the help of
> > of_cpufreq_cooling_register(). This routine tries to get 'struct cpufreq_=
> policy'
> > for CPUs which isn't yet initialed at the time ->init() is called and so =
> we face
> > issues while registering the cooling device.
> >=20
> > Because we can't register cooling device from ->init(), we need a callbac=
> k that
> > is called after the policy is ready to be used and hence ->usable() callb=
> ack.
> >=20
> > The first patch fixes few formatting issues, so that the third patch does=
> n't
> > throw any checkpatch warnings. Second one fixes a potential bug in cpufre=
> q-dt
> > driver. Third one introduces ->usable() callback which will be used in the
> > fourth patch.
> >=20
> > Last three are fixes for cooling core, which may be applied separately by
> > Eduardo if he wants. Sent them in this series as they were sort of connec=
> ted
> > with cpufreq in general.
> >=20
> > Let me know if it still doesn't work properly.
> 
> For the series, the last three patches somehow breaks things. I didn't
> not investigate the reason now, because, well, I think we should take
> one thing at a time.

Agreed!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
