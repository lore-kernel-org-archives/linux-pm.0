From: Ankita Garg <ankita@in.ibm.com>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
 Memory Power Management
Date: Thu, 30 Jun 2011 10:07:59 +0530
Message-ID: <20110630043759.GA12667__3952.83648181266$1309408764$gmane$org@in.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110629130038.GA7909@in.ibm.com>
	<1309367184.11430.594.camel@nimitz>
	<20110629174220.GA9152@in.ibm.com>
	<1309370342.11430.604.camel@nimitz>
	<20110629181755.GG3646@dirshya.in.ibm.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110629181755.GG3646@dirshya.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org, thomas.abraham@linaro.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 29, 2011 at 11:47:55PM +0530, Vaidyanathan Srinivasan wrote:
> * Dave Hansen <dave@linux.vnet.ibm.com> [2011-06-29 10:59:02]:
> 
> > On Wed, 2011-06-29 at 23:12 +0530, Ankita Garg wrote:
> 
> > > 	5. Being able to group these pieces of hardware for purpose of
> > > 	   higher savings. 
> > 
> > Do you really mean group, or do you mean "turn as many off as possible"?
> 
> Grouping based on hardware topology could help save more power at
> higher granularity.  In most cases just turning as many off as
> possible will work.  But the design should allow grouping based on
> certain rules or hierarchies.
>

For instance, on the Samsung Exynos 4210 board, the controller
dynamically transitions 512MB of memory into lower powerdown state
depending on whether it is being actively referenced or not.
Additionally, if two such 512MB devices are free (as hinted by
software), the controller can cut the clock going into that memory
channel to which the two devices are connected, further reducing the
power consumption.
 
-- 
Regards,
eAnkita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs,
Bangalore, India
