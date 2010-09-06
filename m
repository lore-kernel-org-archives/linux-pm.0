From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Mon, 6 Sep 2010 14:00:05 +0200
Message-ID: <201009061400.05637.trenn__29791.9379118413$1283774474$gmane$org@suse.de>
References: <AANLkTikvbn3+JPc7pnGZk-H4B71MHTu+-vjuzfJw_7PC@mail.gmail.com>
	<201009061243.00479.trenn@suse.de>
	<AANLkTik8_ixOcFy=c4hPZknyUqPYB+2hzQTNK9wVok4q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTik8_ixOcFy=c4hPZknyUqPYB+2hzQTNK9wVok4q@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Monday 06 September 2010 13:27:13 Jean Pihet wrote:
> On Mon, Sep 6, 2010 at 12:42 PM, Thomas Renninger <trenn@suse.de> wrote:
...
> In order to reach an efficient low power mode you
> need to ensure that all clocks in a clock domain are idled or cut off
> (automatically by the HW or with the intervention of SW drivers).
> 
> The HW complexity requires the tracing of all those clocks/power
> states, that is why new events are proposed.
Hm, but if the HW can switch clocks behind your back, how do you
realize that to throw a perf clock power event then?
Theoretically you need to poll to keep track of HW switching the
clocks?

    Thomas
