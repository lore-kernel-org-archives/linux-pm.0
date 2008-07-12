From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Date: Sat, 12 Jul 2008 15:55:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0807121551590.17776-100000__27527.2700972439$1215892739$gmane$org@netrider.rowland.org>
References: <m1ej5z4v7v.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1ej5z4v7v.fsf@frodo.ebiederm.org>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 11 Jul 2008, Eric W. Biederman wrote:

> > Forcing the second set of requests to filter through an extra software 
> > layer is a clumsy way of accomplishing this.  There ought to be a 
> > better approach.
> 
> The point was something different.  The reasons we can not store the
> state of the system with the hardware devices logically hot unplugged
> (and thus reuse all of the find device hotplug methods) is because
> things like the filesystem layer don't know how to cope with their
> block devices going away an coming back.

This is not how the procedure works.  During hibernation, block devices
are not logically hot-unplugged.  (If they were then they couldn't be
used for writing the memory image.)  Instead, they are quiesced or
suspended and their input queues are plugged.

> That is the problem inserting an virtual software device in the middle
> can solve.  If that works should there be a better way?  Certainly but
> to prove it out starting with a block device wrapper is a trivial way to
> go.

This sounds like a solution to a non-existent problem.

Alan Stern
