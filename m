From: Yadwinder Singh Brar <yadi.brar01@gmail.com>
Subject: Re: [RFC v2 1/4] power: asv: Add common ASV support for Samsung SoCs
Date: Fri, 27 Dec 2013 01:28:06 +0900
Message-ID: <CAKew6eUn0PNE0Jig5Nyf0f_deK0OX0q6chOGyRKR2AbsjXYUvw@mail.gmail.com>
References: <1384515691-26299-1-git-send-email-sachin.kamat@linaro.org>
 <4229773.U5JovcREjb@amdc1227>
 <CAKew6eVSOQaHjYj3JRhJKnozY26OkeUGhvC2usadfUqW9hyu2Q@mail.gmail.com>
 <11098201.47kElN2vGm@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <11098201.47kElN2vGm@flatron>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Yadwinder Singh Brar <yadi.brar@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Sachin Kamat <sachin.kamat@linaro.org>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@google.com>, Andrew Bresticker <abrestic@google.com>, Kukjin Kim <kgene.kim@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Tomasz,

Sorry for being late.

On Sun, Dec 15, 2013 at 10:51 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Sunday 15 of December 2013 22:30:13 Yadwinder Singh Brar wrote:
> [snip]
>> >> +
>> >> +     return NULL;
>> >> +}
>> >> +
>> >> +unsigned int asv_get_volt(enum asv_type_id target_type,
>> >> +                                             unsigned int target_freq)
>> >
>> > Do you need this function at all? I believe this is all about populating
>> > device's OPP array with frequencies and voltages according to its ASV
>> > level. Users will be able to query for required voltage using standard OPP
>> > calls then, without a need for ASV specific functions like this one.
>> >
>>
>> Yes, I had put a comment in initial version after commit message :
>> "Hopefully asv_get_volt() can go out in future, once all users start using OPP
>> library." , which seems to be missed in this version.
>> I had kept it for the time being in initial version, to keep it
>> usable(for testing) with
>> existing cpufreq drivers, which need to reworked and may take time.
>
> Hmm, at the moment none of cpufreq drivers use ASV, so they need to be
> reworked anyway to use it either by the means of a private get_volt
> function or OPP framework. I agree that OPP may require more work,
> though.
>
> If we decide to keep this function in final version, a comment should be
> added saying that its usage is deprecated in favor of generic OPP helpers.
>

yes.

>>
>> [snip]
>> >> +
>> >> +     for (i = 0; i < asv_info->nr_dvfs_level; i++) {
>> >> +             if (dev_pm_opp_add(dev, dvfs_table[i].freq * 1000,
>> >> +                     dvfs_table[i].volt)) {
>> >> +                     dev_warn(dev, "Failed to add OPP %d\n",
>> >> +                              dvfs_table[i].freq);
>> >
>> > Hmm, shouldn't it be considered a failure instead?
>> >
>>
>> hmm, not really always. Theoretically system with some less(failed to add)
>> levels can work. Moreover I had prefered to keep it only warning, just to
>> keep the behaviour of  asv_init_opp_table() similar to that of its
>> counter part of_init_opp_table().
>
> I'm not quite convinced about it. If dev_pm_opp_add() fails, doesn't it mean
> that something broke seriously in upper layer and we should propagate the
> error down? Especially when looking at opp_add(), the only failure
> conditions I can find are memory allocation errors which mean that the
> system is unlikely to operate correctly anyway.
>

yes, for the time being i had prefered to keep it similar to
of_init_opp_table() behaviour wise.
If required both should be fixed.


>> [snip]
>> >
>> > Hmm, I don't see a point of these three separate callbacks above.
>> >
>> > In general, I'd suggest a different architecture. I'd see this more as:
>> >
>> > 1) Platform code registers static platform device to instantiate SoC ASV
>> >    driver.
>> > 2) SoC specific ASV driver probes, reads group ID from hardware register,
>> >    calls register_asv_member() with appropriate DVFS table for detected
>> >    group.
>> > 3) Driver using ASV calls asv_init_opp_table() with its struct device and
>> >    ASV member name, which causes the ASV code to fill device's operating
>> >    point using OPP calls.
>> >
>> > Now client driver has all the information it needs and the work of ASV
>> > subsystem is done. The control flow between drivers would be much simpler
>> > and no callbacks would have to be called.
>> >
>>
>> Architecture stated above seems to be a subset(one possible way of use),
>> of the proposed architecture. If someone really have nothing much to do,
>> he can adopt the above stated approach using this framework also,
>> callbacks are not mandatory.
>
> I believe that kernel design principles are to first start with something
> simple and then if a real need for an extension shows up then extend
> existing code base with missing features.
>

Sorry, I can't see it complex as with architecture stated above
also we have to implement similar structure in drivers as we are already
doing now individually in each soc driver.

>>
>> Since we usually have more things to do other than only reading
>> fused group value and simply parsing a table index, so in drivers we have to
>> implement functions to segregate stuff and different people do it in
>> different way. Its an attempt to provide a way to keep structure(functions)
>> similar for easy understanding and factoring out of common code.
>
> I fail to see those more things. Could you elaborate a bit about them?

Usually we need to implement functions in drivers clearly demarking following :
1- Reading chip info (which can be done at probe time only once for all).
2- Parse/Calculate(modify) ASV group.
3- Any Group specific one time setting. eg ABB settings.
4- Parsing and modifying table ( implementing Voltage locking, if
required based on locking info bits).


Best Regards,
Yadwinder
