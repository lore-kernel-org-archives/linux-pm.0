From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: highbank: do not initialize array with a loop
Date: Mon, 25 Feb 2013 09:11:18 +0530
Message-ID: <CAOh2x=nDZpBaqjzO22k66Bb30mVEhAdy02EFDP9RDibA50Sx7A@mail.gmail.com>
References: <1361725277-5125-1-git-send-email-emilio@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1361725277-5125-1-git-send-email-emilio@elopez.com.ar>
Sender: cpufreq-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>
Cc: rjw@sisk.pl, shawn.guo@linaro.org, mark.langsdorf@calxeda.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 24, 2013 at 10:31 PM, Emilio L=F3pez <emilio@elopez.com.ar>=
 wrote:
> As uninitialized array members will be initialized to zero, we can
> avoid using a for loop by setting a value to it.
>
> Signed-off-by: Emilio L=F3pez <emilio@elopez.com.ar>
> ---
> Note that I don't own any device using this driver, it has only been =
compile
> tested, but it shouldn't cause any issues.
>
>  drivers/cpufreq/highbank-cpufreq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/hig=
hbank-cpufreq.c
> index 66e3a71..30d4ae1 100644
> --- a/drivers/cpufreq/highbank-cpufreq.c
> +++ b/drivers/cpufreq/highbank-cpufreq.c
> @@ -28,13 +28,9 @@
>
>  static int hb_voltage_change(unsigned int freq)
>  {
> -       int i;
> -       u32 msg[HB_CPUFREQ_IPC_LEN];
> +       u32 msg[HB_CPUFREQ_IPC_LEN] =3D {HB_CPUFREQ_CHANGE_NOTE};
>
> -       msg[0] =3D HB_CPUFREQ_CHANGE_NOTE;
>         msg[1] =3D freq / 1000000;

I think this can also be part of the definition of array, isn't it?

So it would be something like:

u32 msg[HB_CPUFREQ_IPC_LEN] =3D {HB_CPUFREQ_CHANGE_NOTE, freq / 1000000=
};

> -       for (i =3D 2; i < HB_CPUFREQ_IPC_LEN; i++)
> -               msg[i] =3D 0;
>
>         return pl320_ipc_transmit(msg);
>  }
> --
> 1.8.2.rc0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
