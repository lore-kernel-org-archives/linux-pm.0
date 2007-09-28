From: "Chakri n" <chakriin5@gmail.com>
Subject: Re: A unresponsive file system can hang all I/O in the
	system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Fri, 28 Sep 2007 01:27:18 -0700
Message-ID: <92cbf19b0709280127yba48b60wfe58e532944894ca__2422.66175705499$1190993309$gmane$org@mail.gmail.com>
References: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
	<20070927235034.ae7bd73d.akpm@linux-foundation.org>
	<1190962752.31636.15.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1190962752.31636.15.camel@twins>
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

Thanks.

The BDI dirty limits sounds like a good idea.

Is there already a patch for this, which I could try?

I believe it works like this,

Each BDI, will have a limit. If the dirty_thresh exceeds the limit,
all the I/O on the block device will be synchronous.

so, if I have sda & a NFS mount, the dirty limit can be different for
each of them.

I can set dirty limit for
 -  sda to be 90% and
 -  NFS mount to be 50%.

So, if the dirty limit is greater than 50%, NFS does synchronously,
but sda can work asynchronously, till dirty limit reaches 90%.

Thanks
--Chakri

On 9/27/07, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Thu, 2007-09-27 at 23:50 -0700, Andrew Morton wrote:
>
> > What we _don't_ want to happen is for other processes which are writing to
> > other, non-dead devices to get collaterally blocked.  We have patches which
> > might fix that queued for 2.6.24.  Peter?
>
> Nasty problem, don't do that :-)
>
> But yeah, with per BDI dirty limits we get stuck at whatever ratio that
> NFS server/mount (?) has - which could be 100%. Other processes will
> then work almost synchronously against their BDIs but it should work.
>
> [ They will lower the NFS-BDI's ratio, but some fancy clipping code will
>   limit the other BDIs their dirty limit to not exceed the total limit.
>   And with all these NFS pages stuck, that will still be nothing. ]
>
>
>
>
