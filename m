From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
	Memory Power Management
Date: Wed, 6 Jul 2011 11:45:41 +0300
Message-ID: <CAOJsxLHQP=-srK_uYYBsPb7+rUBnPZG7bzwtCd-rRaQa4ikUFg__49968.0865942084$1309978481$gmane$org@mail.gmail.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110629130038.GA7909@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110629130038.GA7909@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ankita Garg <ankita@in.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org, thomas.abraham@linaro.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, Christoph Lameter <cl@linux.com>, linux-arm-kernel@lists.infradead.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Ankita,

[ I don't really know anything about memory power management but
  here's my two cents since you asked for it. ]

On Wed, Jun 29, 2011 at 4:00 PM, Ankita Garg <ankita@in.ibm.com> wrote:
> I) Dynamic Power Transition
>
> The goal here is to ensure that as much as possible, on an idle system,
> the memory references do not get spread across the entire RAM, a problem
> similar to memory fragmentation. The proposed approach is as below:
>
> 1) One of the first things is to ensure that the memory allocations do
> not spill over to more number of regions. Thus the allocator needs to
> be aware of the address boundary of the different regions.

Why does the allocator need to know about address boundaries? Why
isn't it enough to make the page allocator and reclaim policies favor using
memory from lower addresses as aggressively as possible? That'd mean
we'd favor the first memory banks and could keep the remaining ones
powered off as much as possible.

IOW, why do we need to support scenarios such as this:

   bank 0     bank 1   bank 2    bank3
 | online  | offline | online  | offline |

instead of using memory compaction and possibly something like the
SLUB defragmentation patches to turn the memory map into this:

   bank 0     bank 1   bank 2   bank3
 | online  | online  | offline | offline |

> 2) At the time of allocation, before spilling over allocations to the
> next logical region, the allocator needs to make a best attempt to
> reclaim some memory from within the existing region itself first. The
> reclaim here needs to be in LRU order within the region. =A0However, if
> it is ascertained that the reclaim would take a lot of time, like there
> are quite a fe write-backs needed, then we can spill over to the next
> memory region (just like our NUMA node allocation policy now).

I think a much more important question is what happens _after_ we've
allocated and free'd tons of memory few times. AFAICT, memory
regions don't help with that kind of fragmentation that will eventually
happen anyway.

					Pekka
