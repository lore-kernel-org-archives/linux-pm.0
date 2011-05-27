From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/10] mm: Introduce the memory regions data
	structure
Date: Fri, 27 May 2011 14:31:52 -0700
Message-ID: <1306531912.22505.84.camel__34142.8749649369$1306876337$gmane$org@nimitz>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<1306499498-14263-2-git-send-email-ankita@in.ibm.com>
	<1306510203.22505.69.camel@nimitz>
	<20110527182041.GM5654@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110527182041.GM5654@dirshya.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: svaidy@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, Ankita Garg <ankita@in.ibm.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2011-05-27 at 23:50 +0530, Vaidyanathan Srinivasan wrote:
> The overall idea is to have a VM data structure that can capture
> various boundaries of memory, and enable the allocations and reclaim
> logic to target certain areas based on the boundaries and properties
> required. 

It's worth noting that we already do targeted reclaim on boundaries
other than zones.  The lumpy reclaim and memory compaction logically do
the same thing.  So, it's at least possible to do this without having
the global LRU designed around the way you want to reclaim.

Also, if you get _too_ dependent on the global LRU, what are you going
to do if our cgroup buddies manage to get cgroup'd pages off the global
LRU?  

-- Dave
