From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RESEND PATCH 0/5] cpufreq: db8500: Rename driver and update some
 parts
Date: Fri, 21 Dec 2012 11:18:28 -0600
Message-ID: <CAPtuhTgJysTATpAjG5fJv_RUgL-60fwpDYcoF2KUQ8U7+W=Yjg@mail.gmail.com>
References: <1355153142-9534-1-git-send-email-ulf.hansson@stericsson.com>
 <CAPtuhTgcmdxtG9B6L5NMyLCrhQh2o0DFkq47e_YCMoBzVhaF=g@mail.gmail.com>
 <CAPDyKFpN_MM+3N6U07UFu71rEPFkjwExCsnTwMkXbt0ei9ryfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpN_MM+3N6U07UFu71rEPFkjwExCsnTwMkXbt0ei9ryfg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Philippe Begnic <philippe.begnic@st.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jonas Aberg <jonas.aberg@stericsson.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, cpufreq@vger.kernel.org, Rickard Andersson <rickard.andersson@stericsson.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 13, 2012 at 3:20 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 December 2012 21:56, Mike Turquette <mturquette@linaro.org> wrote:
>> On Mon, Dec 10, 2012 at 7:25 AM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>> This patchset starts by renaming the db8500 cpufreq driver to a more generic
>>> name. There are new variants which rely on it too, so instead we give it a
>>> family name of dbx500.
>>>
>>> On top of that a fixup patch for initialization of the driver and some minor
>>> cleanup patches are included as well.
>>>
>>> These patches can be material for 3.8.
>>>
>>> Since some patches for the db8500 cpufreq driver has recently been merged
>>> through Mike Turquette's clk tree, I decided to base these patches on top
>>> of the clk-next branch. So I hope Mike is fine by merging these patches
>>> through his tree.
>>>
>>> So I will try to collect ACKs from Rafael for the cpufreq patches. The
>>> mfd patch has already been ACKED by Samuel.
>>>
>>
>> Ulf,
>>
>> Just FYI clk-next has been pulled by Linus for 3.8.  I can still take
>> this branch once Rafael ACKs the CPUfreq bits if you want, but I think
>> you have more options now that clk-next is merged in.  It's up to you.
>
> I think the easiest way forward (at least for me :-) ) would be if we
> could send them as for 3.8 rcs. Is that possible for you Mike?
>

Hi Ulf,

I did not want to leave you hanging on this point.  I decided at the
last minute to not bring a development platform or a nice laptop on my
vacation so I will not be sending any more pull requests to Linus for
3.8-rc unless some patches come in which are just obvious fixes.  Even
then I will wait until I return in January to properly test any fixes
before I send the request out.

Sorry that these patches did not make it in for 3.8 but I will queue
them up into clk-next in January.

Thanks,
Mike

>>
>> Regards,
>> Mike
>
> Thanks!
>
> Ulf Hansson
