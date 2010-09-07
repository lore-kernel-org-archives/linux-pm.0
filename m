From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Tue, 7 Sep 2010 09:28:56 +0200
Message-ID: <AANLkTik08ezo2ui-P7mSqSt4VR6wzWYH0hAyNTZALbi0__20598.750425461$1283869957$gmane$org@mail.gmail.com>
References: <AANLkTikvbn3+JPc7pnGZk-H4B71MHTu+-vjuzfJw_7PC@mail.gmail.com>
	<201009061243.00479.trenn@suse.de>
	<AANLkTik8_ixOcFy=c4hPZknyUqPYB+2hzQTNK9wVok4q@mail.gmail.com>
	<201009061400.05637.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009061400.05637.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Thomas,

On Mon, Sep 6, 2010 at 2:00 PM, Thomas Renninger <trenn@suse.de> wrote:
> On Monday 06 September 2010 13:27:13 Jean Pihet wrote:
>> On Mon, Sep 6, 2010 at 12:42 PM, Thomas Renninger <trenn@suse.de> wrote:
> ...
>> In order to reach an efficient low power mode you
>> need to ensure that all clocks in a clock domain are idled or cut off
>> (automatically by the HW or with the intervention of SW drivers).
>>
>> The HW complexity requires the tracing of all those clocks/power
>> states, that is why new events are proposed.
> Hm, but if the HW can switch clocks behind your back, how do you
> realize that to throw a perf clock power event then?
Such clocks are automatically shut off when there is no activity on
the module, this allows the system to reach a lower power state. All
that is needed is to ensure the modules are correctly configured to
shut off unneeded clocks automatically.

> Theoretically you need to poll to keep track of HW switching the
> clocks?
No. I would not poll hundreds of clocks.
Furthermore there is no event to be thrown away, in the case the
reached power mode is not 'deep' enough you need a trace point showing
what blocked the transition. There is still work to do to achieve
that, it is coming soon.

>
> =A0 =A0Thomas
>

Note: a re-spin of the patch has been sent on a new thread.

Jean
