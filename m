From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/4 -mm] kexec based hibernation -v7 : kexec
	jump
Date: Sun, 9 Dec 2007 01:19:56 +0100
Message-ID: <200712090119.57826.rjw__40176.1549678215$1197158572$gmane$org@sisk.pl>
References: <1197042810.24045.61.camel@caritas-dev.intel.com>
	<20071208235344.GA17005@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071208235344.GA17005@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sunday, 9 of December 2007, Pavel Machek wrote:
> Hi!
> 
> > This patch implements the functionality of jumping between the kexeced
> > kernel and the original kernel.
> > 
> > To support jumping between two kernels, before jumping to (executing)
> > the new kernel and jumping back to the original kernel, the devices
> > are put into quiescent state, and the state of devices and CPU is
> > saved. After jumping back from kexeced kernel and jumping to the new
> > kernel, the state of devices and CPU are restored accordingly. The
> > devices/CPU state save/restore code of software suspend is called to
> > implement corresponding function.
> > 
> > To support jumping without reserving memory. One shadow backup page
> > (source page) is allocated for each page used by new (kexeced) kernel
> > (destination page). When do kexec_load, the image of new kernel is
> > loaded into source pages, and before executing, the destination pages
> > and the source pages are swapped, so the contents of destination pages
> > are backupped. Before jumping to the new (kexeced) kernel and after
> > jumping back to the original kernel, the destination pages and the
> > source pages are swapped too.
> > 
> > A jump back protocol for kexec is defined and documented. It is an
> > extension to ordinary function calling protocol. So, the facility
> > provided by this patch can be used to call ordinary C function in real
> > mode.
> > 
> > A set of flags for sys_kexec_load are added to control which state are
> > saved/restored before/after real mode code executing. For example, you
> > can specify the device state and FPU state are saved/restored
> > before/after real mode code executing.
> > 
> > The states (exclude CPU state) save/restore code can be overridden
> > based on the "command" parameter of kexec jump. Because more states
> > need to be saved/restored by hibernating/resuming.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> I'm not kexec hacker... but maybe this is in good enough state to be
> merged? It is useful on its own: kexec jump and back means we can dump
> system then continue running, for example...

As far as I'm concerned, patches [1/4] and [2/4] can go.

The other two are not in that shape yet (especially the [3/4] patch).

Greetings,
Rafael
