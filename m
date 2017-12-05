From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal: tegra: allow sensor registeration to fail
Date: Mon, 4 Dec 2017 18:46:28 -0800
Message-ID: <20171205024625.GC4949@localhost.localdomain>
References: <1509148453-11388-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1509148453-11388-1-git-send-email-nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Fri, Oct 27, 2017 at 04:54:13PM -0700, Nicolin Chen wrote:
> Not all sensors may be used on a platform. So there could be
> some missing thermal zones in the Device Tree. However, the
> the driver now errors out whenever a sensor fails to register
> the thermal zone.
>=20
> Since the driver could live with other sensors, this change
> allows other sensors to continue the registerations even if
> one sensor fails to register.

What would be the use case you want to have your chip running with
failed to probe thermal zones ? If they are failing to probe
shouldnt you fix the DT nodes?

a system with correct DT, failed to probe zones is a real bug.
Either in the DT or in the code.

>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>=20
