From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: s3c64xx: remove incorrect __init annotation
Date: Mon, 2 Jan 2017 22:19:29 +0100
Message-ID: <CAJZ5v0jaKnn+LTTdpgxaFLNaYSuqV8d9PKphOnHrPw0Zp_Uj5w@mail.gmail.com>
References: <20161216090625.2235668-1-arnd@arndb.de>
 <20170102070903.GC8588@vireshk-i7>
 <20170102173651.hvsfalhcmisv4mtv@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102173651.hvsfalhcmisv4mtv@kozik-lap>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 2, 2017 at 6:36 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Jan 02, 2017 at 12:39:03PM +0530, Viresh Kumar wrote:
>> On 16-12-16, 10:06, Arnd Bergmann wrote:
>> > s3c64xx_cpufreq_config_regulator is incorrectly annotated
>> > as __init, since the caller is also not init:
>> >
>> > WARNING: vmlinux.o(.text+0x92fe1c): Section mismatch in reference from the function s3c64xx_cpufreq_driver_init() to the function .init.text:s3c64xx_cpufreq_config_regulator()
>> >
>> > With modern gcc versions, the function gets inline, so we don't
>> > see the warning, this only happens with gcc-4.6 and older.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > ---
>> >  drivers/cpufreq/s3c64xx-cpufreq.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
>> > index 176e84cc3991..0cb9040eca49 100644
>> > --- a/drivers/cpufreq/s3c64xx-cpufreq.c
>> > +++ b/drivers/cpufreq/s3c64xx-cpufreq.c
>> > @@ -107,7 +107,7 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
>> >  }
>> >
>> >  #ifdef CONFIG_REGULATOR
>> > -static void __init s3c64xx_cpufreq_config_regulator(void)
>> > +static void s3c64xx_cpufreq_config_regulator(void)
>> >  {
>> >     int count, v, i, found;
>> >     struct cpufreq_frequency_table *freq;
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Rafael,
> Are you going to pick it up?

I thought I did, didn't I?

Thanks,
Rafael
