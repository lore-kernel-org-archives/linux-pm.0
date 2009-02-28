From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 27 Feb 2009 19:20:02 -0800
Message-ID: <d6200be20902271920l49360e54y9cac06818645e13@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<d6200be20902111542r3592f64dt41a282221aed1268@mail.gmail.com>
	<200902122322.30864.rjw@sisk.pl>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org> <20090226150430.GA1398@ucw.cz>
	<d6200be20902261311q103641dap57425fc8e49cd549@mail.gmail.com>
	<20090226213608.GB2214@elf.ucw.cz>
	<d6200be20902261616g1472c9d6u5e01a6941e37be6e@mail.gmail.com>
	<20090227095650.GA4582@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090227095650.GA4582@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "ncunningham@crca.org.au" <ncunningham@crca.org.au>, "u.luckas@road.de" <u.luckas@road.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "swetland@google.com" <swetland@google.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 27, 2009 at 1:56 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >> As far as I can tell the sleepy patches tries to enter suspend if the
>> >> system is idle. If you plan to wake back up for the first timer, then
>> >> the end result of this is the same as what we get by entering the low
>> >> power state from arch_idle in the msm platform. Due to the frequent
>> >> wakeups, the power use is higher than our suspend state. If you don't
>> >> wake up on the first timer, you need something like the wakelock api
>> >> so apps specify that they need to run even if they were inactive for 3
>> >> seconds.
>> >
>> > You understand it right... it wakes up on first event. So you
>> > eliminate all the timers that fire too often... and fix userspace if
>> > neccessary.
>> >
>> > Given that your 3rd party apps are written in java, you should have
>> > enough control over them.
>>
>> How does the language the apps are written in affect this problem? Are
>> you saying that java apps should not be allowed to run every second?
>
> I'm trying to say that you have pretty good control over java apps. So

I'm trying to say that we do not.

> you could for example make them call modified select with sloppiness,
> or make them set their own sloppiness etc...
>
>> > What in-kernel timers are causing problems for you?
>>
>> I don't know for sure, but last time I checked, the the network stack
>> woke up every second. /proc/timer_list shows tick_sched_timer always
>> running in the next second.
>
> I went through those in minimal system, and was able to mostly solve
> that. Can we simply get network stack (etc) fixed?

If you have fixes to eliminate polling in the network stack, please
submit them (unless you already have) as this would benefit every
system. Even if you eliminate all polling in the kernel, and the
platform supports the same low power state from idle, I still think
suspend is a useful way to pause the entire system when it does not
need to run.

-- =

Arve Hj=F8nnev=E5g
