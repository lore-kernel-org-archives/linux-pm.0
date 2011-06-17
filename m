From: Ankita Garg <ankita@in.ibm.com>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
 Memory Power Management
Date: Fri, 17 Jun 2011 20:58:45 +0530
Message-ID: <20110617152845.GA13574__6532.13198897919$1308324596$gmane$org@in.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110613134701.2b23b8d8.kamezawa.hiroyu@jp.fujitsu.com>
	<20110616042044.GA28563@in.ibm.com>
	<20110616181251.caf484b6.kamezawa.hiroyu@jp.fujitsu.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110616181251.caf484b6.kamezawa.hiroyu@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Jun 16, 2011 at 06:12:51PM +0900, KAMEZAWA Hiroyuki wrote:
> On Thu, 16 Jun 2011 09:50:44 +0530
> Ankita Garg <ankita@in.ibm.com> wrote:
> 
> > Hi,
> > 
> > On Mon, Jun 13, 2011 at 01:47:01PM +0900, KAMEZAWA Hiroyuki wrote:
> > > On Fri, 27 May 2011 18:01:28 +0530
> > > Ankita Garg <ankita@in.ibm.com> wrote:
> > > 
> > > > Hi,
> > > > 
> > > 
> > > I'm sorry if you've answered already.
> > > 
> > > Is memory hotplug is too bad and cannot be enhanced for this purpose ?
> > > 
> > > I wonder
> > >   - make section-size smaller (IIUC, IBM's system has 16MB section size)
> > > 
> > >   - add per section statistics
> > > 
> > >   - add a kind of balloon driver which does software memory offline
> > >     (which means making a contiguous chunk of free pages of section_size
> > >      by page migration) in background with regard to memory usage statistics.
> > >     If system says "need more memory!", balloon driver can online pages.
> > > 
> > > can work for your purpose. It can allow you page isolatation and
> > > controls in 16MB unit.  If you need whole rework of memory hotplug, I think
> > > it's better to rewrite memory hotplug, too.
> > >
> > 
> > Interesting idea, but a few issues -
> > 
> > - Correctly predicting memory pressure is difficult and thereby being
> >   able to online the required pages at the right time could be a
> >   challenge
> 
> But it will be required for your purpose, anyway. Isn't it ?
> 
> > - Memory hotplug is a heavy operation, so the overhead involved may be
> >   high
> 
> soft-offline of small amount of pages will not very heavy.
> compaction and cma patches use the same kind of logic.
> 
> 
> > - Powering off memory is just one of the ways in which memory power could
> >   be saved. The platform can also dynamically transition areas of memory
> >   into a  content-preserving lower power state if it is not referenced
> >   for a pre-defined threshold of time. In such a case, we would need a
> >   mechanism to soft offline the pages - i.e, no new allocations to be
> >   directed to that memory
> > 
> 
> Hmm, sounds like a similar idea of CleanCache ?
> 
> Reusing section is much easier than adding new one.., I think.
> 

But sections do not define the granualarity at which memory operations
are done right ? i.e, allocations/deallocations or reclaim cannot be
directed to a section or a group of sections ?

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs,
Bangalore, India
