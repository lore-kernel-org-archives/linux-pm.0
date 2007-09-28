From: "Chakri n" <chakriin5@gmail.com>
Subject: Re: A unresponsive file system can hang all I/O in the
	system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Fri, 28 Sep 2007 02:20:28 -0700
Message-ID: <92cbf19b0709280220o7cdd4b1cua37a8776af68ac25__41541.8306868107$1190993557$gmane$org@mail.gmail.com>
References: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
	<20070927235034.ae7bd73d.akpm@linux-foundation.org>
	<1190962752.31636.15.camel@twins>
	<92cbf19b0709280127yba48b60wfe58e532944894ca@mail.gmail.com>
	<1190968800.31636.26.camel@twins>
	<92cbf19b0709280201o3778f945mf1d8d61cbb3d0558@mail.gmail.com>
	<1190970729.31636.29.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1190970729.31636.29.camel@twins>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>, nfs@lists.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

It's 2.6.23-rc6.

Thanks
--Chakri

On 9/28/07, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Fri, 2007-09-28 at 02:01 -0700, Chakri n wrote:
> > Thanks for explaining the adaptive logic.
> >
> > > However other devices will at that moment try to maintain a limit of 0,
> > > which ends up being similar to a sync mount.
> > >
> > > So they'll not get stuck, but they will be slow.
> > >
> > >
> >
> > Sync should be ok, when the situation is bad like this and some one
> > hijacked all the buffers.
> >
> > But, I see my simple dd to write 10blocks on local disk never
> > completes even after 10 minutes.
> >
> > [root@h46 ~]# dd if=/dev/zero of=/tmp/x count=10
> >
> > I think the process is completely stuck and is not progressing at all.
> >
> > Is something going wrong in the calculations where it does not fall
> > back to sync mode.
>
> What kernel is that?
>
>
>
