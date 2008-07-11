From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Date: Fri, 11 Jul 2008 22:24:35 +0200
Message-ID: <20080711202434.GB6261__22114.1485999853$1215808015$gmane$org@elf.ucw.cz>
References: <1215401122.4660.4.camel@caritas-dev.intel.com>
	<20080708145051.GA14745@redhat.com>
	<20080711122131.b6461ab1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080711122131.b6461ab1.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri 2008-07-11 12:21:31, Andrew Morton wrote:
> On Tue, 8 Jul 2008 10:50:51 -0400 Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > On Mon, Jul 07, 2008 at 11:25:22AM +0800, Huang Ying wrote:
> > > This patch provides an enhancement to kexec/kdump. It implements
> > > the following features:
> > > 
> > > - Backup/restore memory used by the original kernel before/after
> > >   kexec.
> > > 
> > > - Save/restore CPU state before/after kexec.
> > > 
> > 
> > Hi Huang,
> > 
> > In general this patch set looks good enough to live in -mm and
> > get some testing going.
> > 
> > To me, adding capability to return back to original kernel looks
> > like a logical extension to kexec functionality.
> 
> Exciting ;)  It's much less code than I expected.
> 
> I don't think I understand the feature any more.  Once upon a time we
> thought that this might become a new and better (or at least
> better-code-sharing) way of doing suspend-to-disk.  How far are we from
> that?

Well, it will be tricky to get kjump-hibernation right with respect to
ACPI, but we should be fairly close to basic hibernation working with
this. It has major advantage of not needing refrigerator (and few
disadvantages -- like doing aditional boot during suspend).

But main reason I'd like kjump to be in is different -- it should be
useful to stuff like "dump but continue running", etc...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
