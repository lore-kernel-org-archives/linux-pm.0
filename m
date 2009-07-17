From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Fri, 17 Jul 2009 09:40:13 +0800
Message-ID: <1247794814.26272.216.camel__49155.0648388968$1247794907$gmane$org@rzhang-dt>
References: <1247643512.26272.74.camel@rzhang-dt>
	<20090715002916.GC2360@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090715002916.GC2360@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2009-07-15 at 08:29 +0800, Pavel Machek wrote:
> Hi!
> 
> I notice you are still ccing my @suse.cz address. That one no longer
> works :-(. 
> 
> > this is the patch set I made to speed up the device
> > suspend/resume/shutdown process.
> > 
> > A new mechanism called Device Async Actions is introduced in this patch set.
> > The basic idea is that,
> > 1. device declares to support certain kinds of device async action,
> >    like suspend, resume, shutdown, etc.
> > 2. a async domain is create for this device
> > 3. the child device inherits the async domain
> > 4. devices in the same domain suspend/resume/shutdown asynchronously with
> >    the other devices.
> > 
> > Currently, in order to make sure that it won't bring any side effects,
> > I only convert the ACPI battery and i8042 to use this framework, which reduces
> > 0.5s+ S3 time(suspend time plus resume time)???, from 7.0s to less than 6.5s.
> > and about 0.5s shutdown time in my test.
> 
> Hmm, 7seconds is still quite long. What hw is that?
> 
7 seconds including both kernel suspend and resume time.
it takes about 3.2s to suspend and 3.8 seconds to resume.

thanks,
rui
