From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 22:05:30 +0300
Message-ID: <AANLkTinZ_gViUjVmEbkmour3BC=PcchJDARs4GaCuQwO__47346.7804062695$1281639975$gmane$org@mail.gmail.com>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<Pine.LNX.4.44L0.1008120733130.21006-100000@netrider.rowland.org>
	<AANLkTinMwt27wuDUh32F36wpoC54Syzp1_nK9UCxYmEK@mail.gmail.com>
	<20100812125248.GA2763@thunk.org>
	<AANLkTin4=qpDWEKLwes_af6mSCW+ED7v-fWzD34JywU1@mail.gmail.com>
	<20100812182128.GC2763@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100812182128.GC2763@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ted Ts'o <tytso@mit.edu>, Felipe Contreras <felipe.contreras@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, paulmck@linux.vnet.ibm.com, Alan Cox <alan@lxorguk.ukuu>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 12, 2010 at 9:21 PM, Ted Ts'o <tytso@mit.edu> wrote:
> On Thu, Aug 12, 2010 at 07:46:03PM +0300, Felipe Contreras wrote:
>
>> All the Android community had to do is push the drivers *without*
>> suspend blockers, then the Android kernel wouldn't be so different and
>> thus wouldn't be considered a fork. AFAIU the kernel side wakelocks
>> are already in the kernel, so there's no excuse not to merge the
>> drivers.
>
> What's there is not good enough, because it's missing the statistics
> and reporting so that badly behaved kernel and userspace drivers that
> take wakelocks can be found.

You don't need to have all the code merged in, hell, you only needed
wakelock stubs.

You should take the point of view of the community as a whole, and
forget about Android for a second; the important thing is to bring the
code-bases closer, and that means merging the drivers. For that, you
don't need anything extra.

-- 
Felipe Contreras
