From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: standby to disk transition
Date: Tue, 14 Mar 2006 22:13:02 +0100
Message-ID: <200603142213.03000.rjw@sisk.pl>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<200603140036.17051.rjw@sisk.pl> <20060314203350.GG1782@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060314203350.GG1782@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-pm@osdl.org, linux-pm@lists.osdl.org, "Victor Porton, , , " <porton@ex-code.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday 14 March 2006 21:33, Pavel Machek wrote:
> > > We need to be able to rollback the state of the filesystem in memory and on 
> > > disk to the point where the last checkpoint was made. Memory would be 
> > > straight forward if we want to do it dumbly and slowly - just reload the 
> > > whole check pointed image. If we want to be more efficient, we'd want to just 
> > > load the pages that had changed (Mark on (first) write?). But filesystems 
> > > seem to be a whole different story. Do any of the commonly used fses have 
> > > support for checkpointing and rollback back at the moment?
> > 
> > I'm not sure if we need a rollback as such.  What we need is to make sure
> > the filesystems state will be consistent before as well as after we have
> > "reloaded" the snapshot.
> 
> Even if you make sure *kernel* is consistent with changed filesystem,
> userland is going to be badly confused. Imagine what will happen with
> memory mapped files, for example. 

Something like what happens when you suspend with a mounted CD
and mmapped files from there, then you replace the CD while suspended
and resume.  Not a wise thing to do, but I think people will do such things
from time to time and we'd better be prepared to handle them nicely.

> I'm not sure how it could work...

IMO memory mapped files are the most difficult problem here,
but the rest seems to be doable in general.

Rafael
