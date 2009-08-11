From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V2 0/4] introduce device async actions
	mechanism
Date: Tue, 11 Aug 2009 11:53:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908111148060.2562-100000__25411.4259769723$1250006098$gmane$org@iolanthe.rowland.org>
References: <200908111734.58949.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908111734.58949.rjw@sisk.pl>
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
Cc: "dtor@mail.ru" <dtor@mail.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 11 Aug 2009, Rafael J. Wysocki wrote:

> In fact, we don't need the layers at all.  The only thing we have to assure is
> that, during resume, the devices given device depends on will be handled
> before we start to handle this particular device (inversely during suspend).
> 
> Please note that we're not even allowed to start executing the device's
> resume callback before the callbacks of the devices it depends on have
> returned (the same applies to the suspend callbacks, but the other way around).

The general algorithm for maximum parallelism goes as follows: Start by
resuming (in parallel) all the devices which don't depend on anything
else.  Each time a resume finishes, you go on to resume (in parallel)
all the devices which depend only on resumed devices and which haven't
yet started to resume.

As described, this can require a large number of threads.  It also
requires detailed knowledge of which devices depend on others, which we
don't have.

Alan Stern
