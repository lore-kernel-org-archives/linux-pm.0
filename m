From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/9] PM: suspend_block: Abort task freezing
	if a suspend_blocker is active.
Date: Tue, 12 May 2009 18:55:36 +0200
Message-ID: <200905121855.37585.rjw@sisk.pl>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<200905090101.02390.rjw@sisk.pl>
	<20090512100554.GE14217@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090512100554.GE14217@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 12 May 2009, Pavel Machek wrote:
> On Sat 2009-05-09 01:01:01, Rafael J. Wysocki wrote:
> > On Saturday 09 May 2009, Nigel Cunningham wrote:
> > > Hi.
> > > 
> > > On Fri, 2009-05-08 at 16:40 +0200, Rafael J. Wysocki wrote:
> > > > The timeout is actually a workaround for the problem that we don't
> > > > really
> > > > know if tasks are going to react to our freeze requests and how much time it is
> > > > going to take.  The current value of 20 s was chosen after a number of
> > > > experiments showing that in some cases the freezing _was_ going to take so
> > > > much time.  Of course the question is whether it makes sense to give up earlier
> > > > even if tasks would eventually freeze, but that's a different issue.
> > > 
> > > What were the circumstances in which freezing could take 20s?
> > 
> > Compiling the kernel with "make -j<big number>" on a dual core system IIRC.
> 
> IIRC the number happened because I saw up to 5sec under some heavy
> overload, and added some "safety margin".

No, it appeared after a number of experiments I carried out a couple of years
ago. :-)

Best,
Rafael
