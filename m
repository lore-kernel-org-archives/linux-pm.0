From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
Date: Tue, 23 Jun 2015 10:00:25 +0100
Message-ID: <20150623090025.GJ3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <20150623025031.GD16776@linux>
 <20150623071647.GD3245@x1>
 <20150623080309.GI16776@linux>
 <20150623082759.GF3245@x1>
 <20150623083055.GJ16776@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150623083055.GJ16776@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Jun 2015, Viresh Kumar wrote:

> On 23-06-15, 09:27, Lee Jones wrote:
> > Okay, but the reasoning is the same.  I consider the function to ha=
ve
> > failed, but the over-all failure culminates in just a warning that
> > voltage scaling has indeed failed, but we can still go on with
> > frequency scaling.
>=20
> Ahh, I thought that the other opp-table will also have voltages.

Nope.  See patch 1.

> > Unless his is a big blocker for you, I would like to keep these
> > semantics.
>=20
> No, the print is actually fine.

Perfect, thanks.

> > So technically you are correct, but it makes the code slightly more
> > confusing IMHO.  Yes, it's one more line of code, but it's worth it=
 to
> > add clarity.
>=20
> Your call :)

Thanks again.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
