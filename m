From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: Re: [PATCH 2/2] power/reset: at91-poweroff: timely shitdown LPDDR
 memories
Date: Thu, 13 Oct 2016 17:04:06 +0200
Message-ID: <CACh+v5OH4WdMPFiui3q-QDx7s5JrGPxZ8Mc9fJux54hiZV9+fQ@mail.gmail.com>
References: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
 <20161007163427.11454-3-alexandre.belloni@free-electrons.com>
 <CACh+v5NCxPb_U8HOeczHicCD-Wp8BqBzvc1LtCzmEXZ74Cgshw@mail.gmail.com>
 <20161013110317.ee6by6njrvs53ztx@piout.net>
 <CACh+v5PgwXsCoMROO+Vftx8bbhTXP1V-JdZmdwWJ0tgOUW1Axw@mail.gmail.com>
 <20161013134710.rbvsiyu6ala673g4@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161013134710.rbvsiyu6ala673g4@piout.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jean-Jacques Hiblot <jjhiblot@traphandler.com>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Sebastian Reichel <sre@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

2016-10-13 15:47 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> On 13/10/2016 at 14:27:15 +0200, Jean-Jacques Hiblot wrote :
>> 2016-10-13 13:03 GMT+02:00 Alexandre Belloni
>> <alexandre.belloni@free-electrons.com>:
>> > On 12/10/2016 at 14:48:27 +0200, Jean-Jacques Hiblot wrote :
>> >> > +static void at91_lpddr_poweroff(void)
>> >> > +{
>> >> > +       asm volatile(
>> >> > +               /* Align to cache lines */
>> >> > +               ".balign 32\n\t"
>> >> > +
>> >> > +               "       ldr     r6, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
>> >> At first sight, it looks useless. I assume it's used to preload the
>> >> TLB before the LPDDR is turned off.
>> >> A comment to explain why this line is useful would prevent its removal.
>> >
>> > Yes, this is the case. I can add a comment.
>> >
>> > Anyway, I would prefer the whole thing to run from SRAM, as a PIE
>> > instead of relying on the cache.
>>
>> Instead of copying into the SRAM, you can make the cache reliable by
>> preloading it, much like the TLB.
>> LDI is probably not available for most of atmel's SOC, so the only way
>> I can think of, is to execute code from the targeted area. here is an
>> example:
>> +               /*
>> +                * Jump to the end of the sequence to preload instruction cache
>> +                * It only works because the sequence is short enough not to
>> +                * sit accross more than 2 cache lines
>> +                */
>> +               "       b end_of_sequence\n\t"
>> +               "start_of_sequence:\n\t"
>> +
>>                 /* Power down SDRAM0 */
>>                 "       str     %1, [%0, #"
>> __stringify(AT91_DDRSDRC_LPR) "]\n\t"
>>                 /* Shutdown CPU */
>>                 "       str     %3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
>>
>>                 "       b       .\n\t"
>> +
>> +               /*
>> +                * we're now 100% sure that the code to shutdown the LPDDR and
>> +                * the CPU is in cache, go back to do the actual job
>> +                */
>> +               "end_of_sequence:\n\t"
>> +               "       b start_of_sequence\n\t"
>>                 :
>>
>
> I don't think this is necessary. By aligning the instructions properly,
> we are already sure the whole code is loaded into the cache.
right I didn't see the align directive.
>
> My plan is to get rid of the assembly and use PIE so it is written in C
> and we can properly separate the RAM stuff in the ddrc driver.
>
> The mpddrc driver could load its shutdown function in SRAM. The reset
> controller driver would load the reset function in SRAM and the shutdown
> controller would load the poweroff function in SRAM. It would e quite
> cleaner than what we have here.
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
