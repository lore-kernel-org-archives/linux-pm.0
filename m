From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Date: Fri, 11 Jul 2008 23:04:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0807112255450.9023-100000__28407.1130365648$1215832106$gmane$org@netrider.rowland.org>
References: <m1lk076dtj.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1lk076dtj.fsf@frodo.ebiederm.org>
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

> I just realized with a little care the block layer does have support for this,
> or something very close.
> 
> You setup a software raid mirror with one disk device.    The physical
> device can come in and out while the filesystems depend on the real device.

Do you mean "the filesystems depend on the logical RAID device"?  

What's to prevent userspace from accessing the physical device 
directly?

What this amounts to, in the end, is having a way to distinguish the
set of I/O requests coming from the hibernation code (reading or
writing the memory image) from the set of all other I/O requests.  The
driver or the block layer has to be set up to allow the first set
through while blocking the second set.  (And don't forget about the 
complications caused by error-recovery I/O during the hibernation 
activity!)

Forcing the second set of requests to filter through an extra software 
layer is a clumsy way of accomplishing this.  There ought to be a 
better approach.

Alan Stern
