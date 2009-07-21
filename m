From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] mips: decrease size of
	au1xxx_dbdma_pm_regs[][]
Date: Tue, 21 Jul 2009 15:06:09 +0200
Message-ID: <f861ec6f0907210606m334bcd83u7f28f3062e6f6829__38993.4106766761$1248200258$gmane$org@mail.gmail.com>
References: <4A65B8BB.40502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A65B8BB.40502@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-mips@linux-mips.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, ralf@linux-mips.org
List-Id: linux-pm@vger.kernel.org

Hi Roel,

On Tue, Jul 21, 2009 at 2:46 PM, Roel Kluin<roel.kluin@gmail.com> wrote:
> Only registers [0-DDMA_CHANNEL_BASE][0-6] are used by the suspend
> and resume routines.
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> These routines are on the bottom of the file. Only used are
> registers:
>
> au1xxx_dbdma_pm_regs[0][0-3]
>
> and
>
> au1xxx_dbdma_pm_regs[1-NUM_DBDMA_CHANS][0-6]
>
> Is my patch right, that assumes that the array can be smaller, or
> should the storage and recovery of other registers be added?

Actually, I think there's a bug in the save/restore functions.

This:
  for (i = 1, addr = DDMA_CHANNEL_BASE; i < NUM_DBDMA_CHANS; i++) {

should be changed to
 for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++)

as there are 16 individual channels (NUM_DBDMA_CHANS) to save/restore
plus the global ddma block config (the +1).
And looking closer at it, the last register in a channel can be
skipped since it's
read-only (at offset 0x18).

So, 6 slots per channel for 16 channels plus one row for the ddma global
config are enough:

static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS + 1][6];

Thanks!
      Manuel Lauss
