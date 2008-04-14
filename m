From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 11:13:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804141105460.2406-100000__20517.1583024368$1208186965$gmane$org@iolanthe.rowland.org>
References: <200804141411.19385.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804141411.19385.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Apr 2008, Rafael J. Wysocki wrote:

>     "you can assume that the user space is there while ->prepare() is running,
>     but you are supposed to prevent new children of the device from being
>     registered from that point on _and_ you have to make sure that freezable
>     tasks will be able to freeze after ->prepare() has run" (but why on Earth a
>     driver writer is now required to know what's a freezable task etc.?)

This reminds me...  We're going to need a way to make certain
activities mutually exclusive with system sleep.  The simplest example
is loading a kernel module; init and probe routines often end up
causing new child devices to be registered.

The most straightforward approach is to use an rwsem like the one we 
used to have.  However I'm concerned that under some circumstances 
there might be recursive read-locking.  (For example, the init routine 
in a newly-loaded module decides to load yet another module.  Can this 
actually happen?  libusual does something much like it.)

So it's quite possible we'll end up needing a mechanism that resembles 
an rwsem but allows recursive (properly nested) read-locking.  Does 
such a thing exist already, or would it have to be invented?

Alan Stern
