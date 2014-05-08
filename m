From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH] cpufreq: Break out early when frequency equals target_freq
Date: Thu, 08 May 2014 18:46:09 +0300
Message-ID: <536BA6C1.5000200@semaphore.gr>
References: <53600B71.2050904@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53600B71.2050904@semaphore.gr>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29/04/2014 11:28 =CE=BC=CE=BC, Stratos Karafotis wrote:
> Many drivers keep frequencies in frequency table in ascending
> or descending order. When governor tries to change to policy->min
> or policy->max respectively then the cpufreq_frequency_table_target
> could return on first iteration. This will save some iteration cycles=
=2E
>=20
> So, break out early when a frequency in cpufreq_frequency_table
> equals to target one.
>=20
> Testing this during kernel compilation using ondemand governor
> with a frequency table in ascending order, the
> cpufreq_frequency_table_target returned early on the first
> iteration at about 30% of times called.
>=20
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/freq_table.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_tabl=
e.c
> index 8e518c6..1632981 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -137,9 +137,13 @@ int cpufreq_frequency_table_target(struct cpufre=
q_policy *policy,
>  		i =3D pos - table;
>  		if ((freq < policy->min) || (freq > policy->max))
>  			continue;
> +		if (freq =3D=3D target_freq) {
> +			optimal.driver_data =3D i;
> +			break;
> +		}
>  		switch (relation) {
>  		case CPUFREQ_RELATION_H:
> -			if (freq <=3D target_freq) {
> +			if (freq < target_freq) {
>  				if (freq >=3D optimal.frequency) {
>  					optimal.frequency =3D freq;
>  					optimal.driver_data =3D i;
> @@ -152,7 +156,7 @@ int cpufreq_frequency_table_target(struct cpufreq=
_policy *policy,
>  			}
>  			break;
>  		case CPUFREQ_RELATION_L:
> -			if (freq >=3D target_freq) {
> +			if (freq > target_freq) {
>  				if (freq <=3D optimal.frequency) {
>  					optimal.frequency =3D freq;
>  					optimal.driver_data =3D i;
>=20

Gentle reminder.

Thanks,
Stratos
