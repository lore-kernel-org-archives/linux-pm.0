From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Storing Maintainers info around the kernel tree
Date: Thu, 16 Aug 2007 11:31:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708161128540.3757-100000__20855.7105892853$1187278315$gmane$org@iolanthe.rowland.org>
References: <46C469A5.8020003@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46C469A5.8020003@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Salikh Zakirov <salikh@gmail.com>, LKML Kernel <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Junio C Hamano <gitster@pobox.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org, git@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 16 Aug 2007, Rene Herman wrote:

> > It would be much easier to put in the "kernel/somesubsys" directory a 
> > Maintainers file which has:
> 
> It's ofcourse possible, but note that if we want this stuff to be minimally 
> manual, moving files around (and deleting them) then requires editing these 
> actual in-tree files via a tool.
> 
> With the properties deleting files just requires deleting any file-specific 
> properties alongside which is trivial since those are linked from the file.
> 
> Moving stuff works by building a list of all properties that are set on the 
> source starting at the source and destination's highest shared parent 
> directory and then reconstructing this list at the destination, striking 
> properties off the list that are already set at the destination.
> 
> Adding properties, alongside added files or after the fact, could be done 
> via standard patch submissals via the kind of "meta-diff" that already 
> exists for "git move".
> 
> I really believe this stuff should be meta-data -- and these properties as 
> outlined work well it seems.

Please remember that not everybody uses git.  The MAINTAINERS data 
should be available in the kernel source itself.

(Maybe your suggestion is consistent with this -- I simply wanted to 
raise the point.)

Alan Stern
