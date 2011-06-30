From: Ankita Garg <ankita@in.ibm.com>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
 Memory Power Management
Date: Thu, 30 Jun 2011 10:41:23 +0530
Message-ID: <20110630051123.GD12667__38609.1970875443$1309410830$gmane$org@in.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110629130038.GA7909@in.ibm.com>
	<1309367184.11430.594.camel@nimitz>
	<20110629174220.GA9152@in.ibm.com>
	<1309370342.11430.604.camel@nimitz> <m2y60k1jqj.fsf@firstfloor.org>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <m2y60k1jqj.fsf@firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org, thomas.abraham@linaro.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wed, Jun 29, 2011 at 01:11:00PM -0700, Andi Kleen wrote:
> Dave Hansen <dave@linux.vnet.ibm.com> writes:
> >
> > It's also going to be a pain to track kernel references.  On x86, our
> 

As Vaidy mentioned, we are only looking at memory being either allocated
or free, as a way to evacuate it. Tracking memory references, no doubt,
is a difficult proposition and might involve a lot of overhead.
 
> Even if you tracked them what would you do with them?
>
> It's quite hard to stop using arbitary kernel memory (see all the dancing
> memory-failure does) 
> 
> You need to track the direct accesses to user data which happens
> to be accessed through the direct mapping.
> 
> Also it will be always unreliable because this all won't track DMA.
> For that you would also need to track in the dma_* infrastructure,
> which will likely get seriously expensive.
> 

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs,
Bangalore, India
