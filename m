From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Fri, 14 Aug 2009 17:37:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908141735410.2922-100000__41788.850099738$1250286019$gmane$org@iolanthe.rowland.org>
References: <200908142331.26855.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908142331.26855.rjw@sisk.pl>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 Aug 2009, Rafael J. Wysocki wrote:

> > I think it would be worthwhile to track down these unknown problems and 
> > dependencies.  It won't be easy, though...
> 
> Agreed.
> 
> Hm.  Perhaps it's a good idea to get this code in, so that people can play
> with it.  The more people will look into this, the greater the chance to
> identify problematic drivers.

We don't know if the final form will resemble this at all.  So yes, it 
should be made available for testing purposes (especially if there's 
some mechanism for listing dependencies), but it shouldn't go into 
linux-next or anything like that.

Alan Stern
