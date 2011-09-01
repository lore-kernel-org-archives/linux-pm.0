From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC][PATCH 5/5] PM / Domains: Add default power off
	governor function
Date: Thu, 1 Sep 2011 17:17:51 +0200
Message-ID: <CAORVsuW7rFEN8u7RCpmWJamtG2iUbA_zz3ax4hgBjGAZW9vU=A__14869.1484508619$1314930032$gmane$org@mail.gmail.com>
References: <201108310017.03103.rjw@sisk.pl> <201108310022.43850.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108310022.43850.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael,

On Wed, Aug 31, 2011 at 12:22 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Add a function deciding whether or not a given PM domain should
> be powered off on the basis of that domain's devices' PM QoS
> constraints.
>
> ---
> =A0drivers/base/power/domain_governor.c | =A0 96 ++++++++++++++++++++++++=
+++++++++++
> =A0include/linux/pm_domain.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 ++
> =A02 files changed, 103 insertions(+)
>
> Index: linux/include/linux/pm_domain.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/include/linux/pm_domain.h
> +++ linux/include/linux/pm_domain.h
> @@ -49,6 +49,10 @@ struct generic_pm_domain {
> =A0 =A0 =A0 =A0int (*start_device)(struct device *dev);
> =A0 =A0 =A0 =A0int (*stop_device)(struct device *dev);
> =A0 =A0 =A0 =A0bool (*active_wakeup)(struct device *dev);
> + =A0 =A0 =A0 ktime_t power_off_latency;
> + =A0 =A0 =A0 ktime_t power_on_latency;
> + =A0 =A0 =A0 s64 break_even_ns;
> + =A0 =A0 =A0 s64 min_delta_ns;
How are those values populated? Is there a mechanism that dynamically
updates the values?

> =A0};
>
> =A0static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_doma=
in *pd)
> @@ -64,6 +68,9 @@ struct gpd_link {
> =A0};
>
> =A0struct gpd_gov_dev_data {
> + =A0 =A0 =A0 ktime_t start_latency;
> + =A0 =A0 =A0 ktime_t suspend_latency;
> + =A0 =A0 =A0 ktime_t resume_latency;
Same question here.

> =A0 =A0 =A0 =A0s64 break_even_ns;
> =A0};
>
...

Regards,
Jean
