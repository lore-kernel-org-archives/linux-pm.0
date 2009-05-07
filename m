From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] TuxOnIce
Date: Thu, 7 May 2009 19:42:54 +0200
Message-ID: <200905071942.54936.rjw__1702.87331934578$1241718362$gmane$org@sisk.pl>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507120948.GA1531@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507120948.GA1531@ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 07 May 2009, Pavel Machek wrote:
> Hi!
> 
> > I'd like to submit TuxOnIce for review, with a view to seeking to get it
> > merged, perhaps in 2.6.31 or .32 (depending upon what needs work before
> > it can be merged) and the willingness of those who matter.
> > 
> > To briefly summarise the advantages to merging TuxOnIce:
> > 
> > - Support for multiple swap devices
> > - Support for non-swap (an ordinary file can be used)
> > - Uses cryptoapi (LZO support, more than 2x speed of uncompressed data!)
> > - Asynchronous I/O, readahead, multithreaded. Get the maximum throughput
> >   possible with your hardware.
> > - Userspace user interface that lets you abort hibernating and abort
> >   resuming, get nice progress display etc.
> 
> All these are either done by uswsusp already, or could be done w/o
> modifying kernel code.
> 
> > - 8 years of testing and improvement.
> 
> Yeah, 8 years of out of tree testing; while current code is used by
> basically every distro out there.
> 
> > - Full image of memory (LRU pages that don't need to be atomically
> >   copied are saved prior to the atomic copy, then used as the
> >   destination of the atomic copy).
> 
> Yeah, that was the patch that did not go in
> 
> > - Support for resuming a different image after writing an image - makes
> >   powering down a UPS after writing an image doable.
> 
> 
> This can  be done w/o kernel code. Someone had a patch...
> 
> > - Simple to set up (works without any userspace binaries, uses existing
> >   resume= and noresume commandline parameters).
> 
> Given that distros ship uswsusp already... is that really an advantage.
> 
> To summarise disadvantages:
> 
> - only core has 8000 LoC
> - it does stuff that can be easily done in userspace
>      (and that todays distros _do_ in userspace).
> - it duplicates uswsusp functionality.
> - compared to [u]swsusp, it received little testing

Actually, I see advantages of working together versus fighting flame wars.
Please stop that, I'm not going to take part in it this time.

Best,
Rafael
