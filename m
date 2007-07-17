From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Hibernating To Swap Considered Harmful
Date: Tue, 17 Jul 2007 09:10:41 +0200
Message-ID: <200707170910.41971.oliver@neukum.org>
References: <200707121453.49616.rjw@sisk.pl>
	<200707170744.08191.oliver@neukum.org>
	<20070717062803.GA9069@nineveh.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070717062803.GA9069@nineveh.local>
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
To: Joseph Fannin <jfannin@gmail.com>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Am Dienstag 17 Juli 2007 schrieb Joseph Fannin:
> On Tue, Jul 17, 2007 at 07:44:07AM +0200, Oliver Neukum wrote:
> >
> > If yoi want to go the kexec route to hibernation, the dumping kernel
> > would need to mount the filesystem to write to a file. Therefore the
> > suspending kernel would need to sync to disk and lock that file.
> 
> If the file is preallocated, that's not a problem, as there's no need
> to touch filesystem metadata.  There'd need to be some channel to pass

The suspending and the resuming kernel need to touch metadata.
The kernel writing the image does not need to touch it.
You need to make sure that the metadata on disk is in a state that
allows the resuming kernel to find the file.

> the disk blocks that are for writing the image, but that's not going
> to be nearly as complicated as passing the current swap data
> structures from the previous kernel.

You'd need to pass just a bitmap of the swap space. Or you go the
easiest way and use a dedicated partition.
 
> There's no reason to have that file open in the original kernel --
> it should be root-owned (it's full of privledged data) and probably
> mode 000.
> 
> root is free to "dd if=/dev/random of=/dev/mem".  Root owned
> daemons which do bad things are bugs.
> 
> Again, supporting swap files (*which is not optional*) requires the
> very same support.

Why would you need to support swap files?

	Regards
		Oliver
