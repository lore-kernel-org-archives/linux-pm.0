From: Fabian Frederick <fabf@skynet.be>
Subject: Re: [PATCH V2 linux-next] cpufreq: pxa: replace typedef pxa_freqs_t
 by structure
Date: Thu, 30 Apr 2015 20:28:56 +0200 (CEST)
Message-ID: <1161092225.77460.1430418536315.open-xchange@webmail.nmp.proximus.be>
References: <1430335980-9765-1-git-send-email-fabf@skynet.be> <1430369201.2575.10.camel@perches.com>
Reply-To: Fabian Frederick <fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailsec102.isp.belgacom.be ([195.238.20.98]:2121 "EHLO
	mailsec102.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751918AbbD3S26 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Apr 2015 14:28:58 -0400
In-Reply-To: <1430369201.2575.10.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org



> On 30 April 2015 at 06:46 Joe Perches <joe@perches.com> wrote:
>
>
> On Wed, 2015-04-29 at 21:32 +0200, Fabian Frederick wrote:
> > typedef is not really useful here. Replace it by structure
> > to improve readability.typedef should only be used in some cases.
> > (See Documentation/CodingStyle Chapter 5 for details).
>
> trivia:
>
> > diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c
> > b/drivers/cpufreq/pxa2xx-cpufreq.c
> []
> > @@ -86,7 +86,7 @@ static unsigned int sdram_rows;
> >=C2=A0 /* Use the run mode frequencies for the CPUFREQ_POLICY_PERFOR=
MANCE policy
> >*/
> >=C2=A0 #define CCLKCFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 CCLKCFG_TURBO | CCLKCFG_FCS
> >=C2=A0
> > -static pxa_freqs_t pxa255_run_freqs[] =3D
> > +static struct pxa_freqs pxa255_run_freqs[] =3D
>
> Should these be const?

AFAICS yes but this needs some fixes:
drivers/cpufreq/pxa2xx-cpufreq.c: In function 'find_freq_tables':
drivers/cpufreq/pxa2xx-cpufreq.c:218:15: warning: assignment discards '=
const'
qualifier from pointer target type
=C2=A0 =C2=A0 *pxa_freqs =3D pxa255_run_freqs;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^
Maybe another patch ?

Regards,
=46abian
>
> >=C2=A0 {
> >=C2=A0 =C2=A0 =C2=A0/* CPU=C2=A0 =C2=A0MEMBUS=C2=A0 CCCR=C2=A0 DIV2 =
CCLKCFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 run=C2=A0=
 turbo PXbus
> >SDRAM */
> >=C2=A0 =C2=A0 =C2=A0{ 99500,=C2=A0 99500, 0x121, 1,=C2=A0 CCLKCFG, -=
1, -1},=C2=A0 =C2=A0/*=C2=A0 99,=C2=A0 =C2=A099,=C2=A0 =C2=A050,=C2=A0
> >=C2=A050=C2=A0 */
> > @@ -98,7 +98,7 @@ static pxa_freqs_t pxa255_run_freqs[] =3D
> >=C2=A0 };
> >=C2=A0
> >=C2=A0 /* Use the turbo mode frequencies for the CPUFREQ_POLICY_POWE=
RSAVE policy
> >*/
> > -static pxa_freqs_t pxa255_turbo_freqs[] =3D
> > +static struct pxa_freqs pxa255_turbo_freqs[] =3D
> >=C2=A0 {
> >=C2=A0 =C2=A0 =C2=A0/* CPU=C2=A0 =C2=A0MEMBUS=C2=A0 CCCR=C2=A0 DIV2 =
CCLKCFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 run=C2=A0 turbo PXbus SDRAM */
> >=C2=A0 =C2=A0 =C2=A0{ 99500, 99500,=C2=A0 0x121, 1,=C2=A0 CCLKCFG, -=
1, -1},=C2=A0 =C2=A0/*=C2=A0 99,=C2=A0 =C2=A099,=C2=A0 =C2=A050,=C2=A0
> >=C2=A050=C2=A0 */
> > @@ -153,7 +153,7 @@ MODULE_PARM_DESC(pxa255_turbo_table, "Selects t=
he
> > frequency table (0 =3D run table
> >=C2=A0 =C2=A0 =C2=A0((HT) ? CCLKCFG_HALFTURBO : 0) | \
> >=C2=A0 =C2=A0 =C2=A0((T)=C2=A0 ? CCLKCFG_TURBO : 0))
> >=C2=A0
> > -static pxa_freqs_t pxa27x_freqs[] =3D {
> > +static struct pxa_freqs pxa27x_freqs[] =3D {
> >=C2=A0 =C2=A0 =C2=A0{104000, 104000, PXA27x_CCCR(1,=C2=A0 8, 2), 0, =
CCLKCFG2(1, 0, 1),=C2=A0 900000,
> >1705000 },
> >=C2=A0 =C2=A0 =C2=A0{156000, 104000, PXA27x_CCCR(1,=C2=A0 8, 3), 0, =
CCLKCFG2(1, 0, 1), 1000000,
> >1705000 },
> >=C2=A0 =C2=A0 =C2=A0{208000, 208000, PXA27x_CCCR(0, 16, 2), 1, CCLKC=
=46G2(0, 0, 1), 1180000,
> >1705000 },
> > @@ -171,7 +171,7 @@ extern unsigned get_clk_frequency_khz(int info)=
;
> >=C2=A0
> >=C2=A0 #ifdef CONFIG_REGULATOR
> >=C2=A0
> > -static int pxa_cpufreq_change_voltage(pxa_freqs_t *pxa_freq)
> > +static int pxa_cpufreq_change_voltage(struct pxa_freqs *pxa_freq)
> >=C2=A0 {
> >=C2=A0 =C2=A0 =C2=A0int ret =3D 0;
> >=C2=A0 =C2=A0 =C2=A0int vmin, vmax;
> > @@ -202,7 +202,7 @@ static void __init pxa_cpufreq_init_voltages(vo=
id)
> >=C2=A0 =C2=A0 =C2=A0}
> >=C2=A0 }
> >=C2=A0 #else
> > -static int pxa_cpufreq_change_voltage(pxa_freqs_t *pxa_freq)
> > +static int pxa_cpufreq_change_voltage(struct pxa_freqs *pxa_freq)
> >=C2=A0 {
> >=C2=A0 =C2=A0 =C2=A0return 0;
> >=C2=A0 }
> > @@ -211,7 +211,7 @@ static void __init pxa_cpufreq_init_voltages(vo=
id) { }
> >=C2=A0 #endif
> >=C2=A0
> >=C2=A0 static void find_freq_tables(struct cpufreq_frequency_table *=
*freq_table,
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 pxa_freqs_t **pxa_freqs)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct pxa_freqs **pxa_freqs)
> >=C2=A0 {
> >=C2=A0 =C2=A0 =C2=A0if (cpu_is_pxa25x()) {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pxa255_turbo_ta=
ble) {
> > @@ -270,7 +270,7 @@ static unsigned int pxa_cpufreq_get(unsigned in=
t cpu)
> >=C2=A0 static int pxa_set_target(struct cpufreq_policy *policy, unsi=
gned int idx)
> >=C2=A0 {
> >=C2=A0 =C2=A0 =C2=A0struct cpufreq_frequency_table *pxa_freqs_table;
> > -=C2=A0 =C2=A0pxa_freqs_t *pxa_freq_settings;
> > +=C2=A0 =C2=A0struct pxa_freqs *pxa_freq_settings;
> >=C2=A0 =C2=A0 =C2=A0unsigned long flags;
> >=C2=A0 =C2=A0 =C2=A0unsigned int new_freq_cpu, new_freq_mem;
> >=C2=A0 =C2=A0 =C2=A0unsigned int unused, preset_mdrefr, postset_mdre=
fr, cclkcfg;
> > @@ -361,7 +361,7 @@ static int pxa_cpufreq_init(struct cpufreq_poli=
cy
> > *policy)
> >=C2=A0 =C2=A0 =C2=A0int i;
> >=C2=A0 =C2=A0 =C2=A0unsigned int freq;
> >=C2=A0 =C2=A0 =C2=A0struct cpufreq_frequency_table *pxa255_freq_tabl=
e;
> > -=C2=A0 =C2=A0pxa_freqs_t *pxa255_freqs;
> > +=C2=A0 =C2=A0struct pxa_freqs *pxa255_freqs;
> >=C2=A0
> >=C2=A0 =C2=A0 =C2=A0/* try to guess pxa27x cpu */
> >=C2=A0 =C2=A0 =C2=A0if (cpu_is_pxa27x())
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.=
html
> > Please read the FAQ at=C2=A0 http://www.tux.org/lkml/
>
>
>
