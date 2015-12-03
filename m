From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: [PATCH 11/12] cpufreq: arm-big-little: clarify frequency units
Date: Thu, 03 Dec 2015 15:37:44 +0100
Message-ID: <87egf338ef.fsf@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org> <1449091167-20758-12-git-send-email-ben@smart-cactus.org> <1449152534.2817.26.camel@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1449152534.2817.26.camel@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, b.zolnierkie@samsung.com, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Jon Medhurst (Tixy)" <tixy@linaro.org> writes:

> On Wed, 2015-12-02 at 22:19 +0100, Ben Gamari wrote:
>> The frequency units are very confusing in this area as OPPs use Hz
>> whereas cpufreq uses kHz. Be explicit about this in variable naming.
>>=20
>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
>> Signed-off-by: Ben Gamari <ben@smart-cactus.org>
>> ---
>>  drivers/cpufreq/arm_big_little.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_=
little.c
>> index 855599b..2d5761c 100644
>> --- a/drivers/cpufreq/arm_big_little.c
>> +++ b/drivers/cpufreq/arm_big_little.c
>> @@ -130,14 +130,14 @@ static unsigned int bL_cpufreq_get_rate(unsigned i=
nt cpu)
>>  }
>>=20=20
>>  static int
>> -bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
>> +bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate_kHz)
>>  {
>>  	unsigned long volt =3D 0, volt_old =3D 0;
>>  	long freq_Hz;
>>  	u32 old_rate;
>
> IMO variable renaming doesn't seem necessary, if cpufreq uses kHz then
> in a cpufreq driver adding 'kHz' to variable seems redundant, especially
> if Hz values like freq_Hz above are named especially to signal their
> different units.
>=20
Correct; it isn't strictly necessary but it would have saved me half an
hour of poking around trying work out the intent of this code.

> However, if renaming is going to happen it should at
> least be consistent within the same function i.e. also rename the old
> old_rate variable above.
>
That's a reasonable objection. I'd be happy to do that.

snip
>>  static unsigned int
>> -bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>> +bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate=
_kHz)
>>  {
>>  	u32 new_rate, prev_rate;
>
> Ditto. Rename these too to add '_kHz' ?
>
Sure.
>>  	int ret;
>> @@ -209,13 +209,13 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 =
new_cluster, u32 rate)
>>=20=20
>>  	if (bLs) {
>>  		prev_rate =3D per_cpu(cpu_last_req_freq, cpu);
>> -		per_cpu(cpu_last_req_freq, cpu) =3D rate;
>> +		per_cpu(cpu_last_req_freq, cpu) =3D rate_kHz;
>>  		per_cpu(physical_cluster, cpu) =3D new_cluster;
>>=20=20
>>  		new_rate =3D find_cluster_maxfreq(new_cluster);
>>  		new_rate =3D ACTUAL_FREQ(new_cluster, new_rate);
>>  	} else {
>> -		new_rate =3D rate;
>> +		new_rate =3D rate_kHz;
>>  	}
>>=20=20
>>  	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
>> @@ -236,7 +236,7 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 ne=
w_cluster, u32 rate)
>>  	} else if (ret && bLs) {
>>  		per_cpu(cpu_last_req_freq, cpu) =3D prev_rate;
>>  		per_cpu(physical_cluster, cpu) =3D old_cluster;
>> -	}=20
>> +	}
>
> There's a spurious whitespace change here. I know the space you deleted
> shouldn't have been there, but doing tidyups like that generally isn't
> done in patches that don't otherwise affect the code in question.
>
Alright, I can drop that change.

Cheers,

=2D Ben


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWYFO4AAoJEHPt6ejPuu8B5HAH/3FCuuc08BH7teIjr4oLQoJw
+PODZWjN2fq7LQ+BnZjuLTwjB5G3fuoVI1Hp9NatGSBHVH5SUDuRBfLA3KlLQ6ud
D+L/Y8eNpdrJdZclDIXgxr1FatwWvBGOjrrQ5vu8Rbe+2fP7Hev9Lh8VM5RbxI/w
bFUnEx3dNHXYFnfKsIyJpgizwUKd2haBza0IOQQCOZhSANeoQ7+9OKDznJPeSTTH
ttsKS2MwZAEGWJpiHBwKkq9N4jm6bNqpDUGW/vou0L2UDdcJOQ+VV3RsmX2bEo3H
3/PHM2o9W/Lpn6RdOdD1HxJJUvpTr7akhgbi4KI5HD1b6G+8keO1DCJEJrguNJ8=
=98IP
-----END PGP SIGNATURE-----
--=-=-=--
