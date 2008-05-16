From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Fri, 16 May 2008 14:18:36 +0200
Message-ID: <20080516121836.GE22264__39712.3938113966$1210940424$gmane$org@elf.ucw.cz>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<m13aok1pt1.fsf@frodo.ebiederm.org>
	<200805150155.33787.rjw@sisk.pl>
	<m163tfi5sq.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <m163tfi5sq.fsf@frodo.ebiederm.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-05-15 15:03:17, Eric W. Biederman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > Well, it looks like we do similar things concurrently.  Please have a look 
> > here: http://kerneltrap.org/Linux/Separating_Suspend_and_Hibernation
> 
> Yes.  Part of the reason I wanted to separate these two conversations
> I knew something was going on.
> 
> > Similar patches are in the Greg's tree already.
> 
> Taking a look.
> 
> I just can't get past the fact in that the only reason hibernation can
> not use the widely implemented and tested probe/remove is because of
> filesystems on block devices, and that you are proposing to add 4
> methods for each and every driver to handle that case, when they
> don't need ANYTHING!
> 
> I wonder how hard teaching the upper layers to deal with
> hotplug/remove is?

It looked _too_ hard when I was looking... at least if we are thinking
off "keep the filesystem mounted over unplug-replug".

Or do you have something else in mind?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
