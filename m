From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: dt: Add support for r8a7792
Date: Wed, 14 Sep 2016 03:03:02 +0200
Message-ID: <2288419.pXvv2aYonF@vostro.rjw.lan>
References: <1473164300-22017-1-git-send-email-geert+renesas@glider.be> <20160907050259.GL27345@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160907050259.GL27345@vireshk-i7>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 07, 2016 10:32:59 AM Viresh Kumar wrote:
> On 06-09-16, 14:18, Geert Uytterhoeven wrote:
> > Add the compatible string for supporting the generic cpufreq driver on
> > the Renesas R-Car V2H (r8a7792) SoC.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Untested due to lack of hardware.
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index 285ed3e6494e9d22..276378a43321a4e0 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -52,6 +52,7 @@ static const struct of_device_id machines[] __initconst = {
> >  	{ .compatible = "renesas,r8a7779", },
> >  	{ .compatible = "renesas,r8a7790", },
> >  	{ .compatible = "renesas,r8a7791", },
> > +	{ .compatible = "renesas,r8a7792", },
> >  	{ .compatible = "renesas,r8a7793", },
> >  	{ .compatible = "renesas,r8a7794", },
> >  	{ .compatible = "renesas,sh73a0", },
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied.

Thanks,
Rafael
