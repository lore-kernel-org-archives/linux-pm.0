From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Fri, 14 Aug 2009 10:45:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908141044220.2987-100000__38178.8346021951$1250261189$gmane$org@iolanthe.rowland.org>
References: <200908132353.54902.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908132353.54902.rjw@sisk.pl>
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

On Thu, 13 Aug 2009, Rafael J. Wysocki wrote:

> > No, I've only tested it with a few selected drivers.  I'm going to try the
> > "async everyone" scenario, though.
> 
> On HP nx6325 booted with init=/bin/bash it doesn't pass the
> 'echo devices > /sys/power/pm_test && echo mem > /sys/power/state' test.
> 
> The suspend part actually seems to work, but the resume part crashes
> miserably.

Any details?  Can you tell where it crashes?

Maybe I'll try it here just to see what happens...

Alan Stern
