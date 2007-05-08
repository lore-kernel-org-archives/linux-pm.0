From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21 -- Forced to hard power off from attempted
	hibernation
Date: Tue, 8 May 2007 21:20:40 +0200
Message-ID: <200705082120.40508.rjw@sisk.pl>
References: <a44ae5cd0705080009l2e7bac9ayc379acdfe17e2507@mail.gmail.com>
	<200705081224.48600.rjw@sisk.pl>
	<a44ae5cd0705080927v2203543dl7fcee33c139cc4c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <a44ae5cd0705080927v2203543dl7fcee33c139cc4c0@mail.gmail.com>
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
To: Miles Lane <miles.lane@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 8 May 2007 18:27, Miles Lane wrote:
> On 5/8/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Hi,
> >
> > On Tuesday, 8 May 2007 09:09, Miles Lane wrote:
> > > Hello,
> > >
> > > When I tried to hibernate my laptop (HP Pavilion dv1240us), everything
> > > seemed to be working,  but the power never shut off.  I had to hold
> > > down the power button for five seconds.
> >
> > Does the log below finish where the machine hanged?
> 
> It's odd.  I thought that the hang must have occurred down...
> 
> > > [ 2815.639718] pci 0000:00:00.1: LATE freeze
> > > [ 2815.639718] agpgart-intel 0000:00:00.0: LATE freeze
> > > [ 2815.639718] swsusp: critical section:
> > > [ 2815.639718] swsusp: Need to copy 124696 pages
> > > [ 2815.639718] swsusp: Normal pages needed: 114475 + 1024 + 24,
> > > available pages: 118745
> 
> <<< HERE >>>
> 
> > > [ 2815.639718] Intel machine check architecture supported.
> > > [ 2815.639718] Intel machine check reporting enabled on CPU#0.
> > > [ 2815.639718] agpgart-intel 0000:00:00.0: EARLY resume
> 
> Since this is where the suspend process seems to complete and the
> resume begins.

Does this mean that it hanged during the resume?

Rafael

PS
Please keep the CC list when you reply, thanks.
