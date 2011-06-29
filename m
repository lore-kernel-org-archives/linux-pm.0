From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
	Memory Power Management
Date: Wed, 29 Jun 2011 13:11:00 -0700
Message-ID: <m2y60k1jqj.fsf__1948.797729756$1309378540$gmane$org@firstfloor.org>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110629130038.GA7909@in.ibm.com> <1309367184.11430.594.camel@nimitz>
	<20110629174220.GA9152@in.ibm.com> <1309370342.11430.604.camel@nimitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1309370342.11430.604.camel@nimitz> (Dave Hansen's message of
	"Wed, 29 Jun 2011 10:59:02 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, Ankita Garg <ankita@in.ibm.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Dave Hansen <dave@linux.vnet.ibm.com> writes:
>
> It's also going to be a pain to track kernel references.  On x86, our

Even if you tracked them what would you do with them?

It's quite hard to stop using arbitary kernel memory (see all the dancing
memory-failure does) 

You need to track the direct accesses to user data which happens
to be accessed through the direct mapping.

Also it will be always unreliable because this all won't track DMA.
For that you would also need to track in the dma_* infrastructure,
which will likely get seriously expensive.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
