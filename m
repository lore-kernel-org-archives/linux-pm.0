From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Thu, 13 Aug 2009 23:53:54 +0200
Message-ID: <200908132353.54902.rjw__49468.1059419692$1250200463$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908121702520.23954-100000@iolanthe.rowland.org>
	<200908122343.20554.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908122343.20554.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 12 August 2009, Rafael J. Wysocki wrote:
> On Wednesday 12 August 2009, Alan Stern wrote:
> > On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:
> > 
> > > Hi,
> > > 
> > > The following patches introduce a mechanism allowing us to execute device
> > > drivers' suspend and resume callbacks asynchronously during system sleep
> > > transitions, such as suspend to RAM.  The idea is explained in the [1/1] patch
> > > message.
> > > 
> > > Comments welcome.
> > 
> > I get the idea.  Not bad.
> 
> Thanks!
> 
> > Have you tried it in a serious way?  For example, turning on the
> > async_suspend flag for every device?
> 
> No, I've only tested it with a few selected drivers.  I'm going to try the
> "async everyone" scenario, though.

On HP nx6325 booted with init=/bin/bash it doesn't pass the
'echo devices > /sys/power/pm_test && echo mem > /sys/power/state' test.

The suspend part actually seems to work, but the resume part crashes
miserably.

Thanks,
Rafael
