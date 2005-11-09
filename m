From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH 0/2] swsusp: improve freeing of
	memory
Date: Thu, 10 Nov 2005 00:07:09 +0100
Message-ID: <200511100007.09518.rjw@sisk.pl>
References: <200511082355.43984.rjw@sisk.pl> <20051109143040.GA1852@elf.ucw.cz>
	<20051109210402.GA12461@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051109210402.GA12461@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 9 of November 2005 22:04, Pavel Machek wrote:
> Hi!
> 
> > > The patches are on top of 2.6.14-mm1 with the three additional patches of mine
> > > that went to Andrew after 2.6.14-mm1.  For your convenience the whole
> > > series of patches is available at:
> > > 
> > > http://www.sisk.pl/kernel/patches/2.6.14-mm1/
> > > 
> > > as:
> > > 
> > > swsusp-reduce-code-duplication.patch
> > > swsusp-improve-relocation.patch
> > > swsusp-rework-swsusp_suspend.patch
> > > swsusp-introduce-swap-map.patch
> > > swsusp-improve-freeing-memory.patch
> > 
> > I got
> > 
> >   CC      kernel/power/snapshot.o
> ...
> > kernel/power/snapshot.c:49: error: for each function it appears in.)
> > 
> > I tried turning off HIGMEM, that got me rid of snapshot.c:49
> > problem. I killed nr_copy_pages from power.h. I tried suspending
> > twice, and it seems to work okay. I guess they are ready for lkml
> > testing...
> 
> I put it under a bit heavier test (attached), and it survive for a
> hour. Looks good.

Great, thanks a lot.  I've got two days of uptime with it now with several
suspend/resume cycles and some production work in between, so it
looks promising to me too.

BTW, the new USB suspend/resume behaves very well here.  I haven't got any
problems with it so far, although it was under heavy stress in the early
phase of testing of my patches.  Kudos to everyone involved.

Rafael
