From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/9] x86 idle: remove NOP
	cpuinfo_x86.hlt_works_ok flag
Date: Thu, 31 Mar 2011 08:09:12 -0700
Message-ID: <4D949918.8010109__31454.0380299606$1301584217$gmane$org@zytor.com>
References: <67e90d97e0a77df4acd0c75e1bacc7714e011f3e.1301550524.git.len.brown@intel.com>	<b048802b0285a5ff28e74a4309d833116174904a.1301550524.git.len.brown@intel.com>	<20110331061247.GA24786@elte.hu>	<alpine.LFD.2.02.1103310252160.8569@x980>	<20110331081800.GH5938@elte.hu>	<20110331102355.17d30a38@lxorguk.ukuu.org.uk>	<20110331092721.GA16570@elte.hu>	<20110331103320.5a72ff8c@lxorguk.ukuu.org.uk>	<20110331093528.GA19288@elte.hu>	<4D948D86.2050607@zytor.com>
	<20110331154103.70d88899@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110331154103.70d88899@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 03/31/2011 07:41 AM, Alan Cox wrote:
>>
>> What it was was bad power supplies or low-capacitance, high-inductance
>> power distribution that happened to work with MS-DOS which always burned
>> the CPU at 100% and therefore left the power draw relatively consistent
>> current.  A proper OS putting the CPU in HLT produced a lot more high
>> frequency noise on the power busses, with disastrous results without
>> proper bypass.
> 
> And also chipset errata in some cases - eg some revisions of the CS5510
> hung the box solid if a CPU hlt occurred during an IDE transfer. I don't
> think any CS5510s are still around although I've had mail from someone
> with a CS5520 in use not that long ago so who knows!
> 
> The joy of ancient history.

Ah, yes, I guess there was a special cycle on the bus which the chipset
could misinterpret.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
