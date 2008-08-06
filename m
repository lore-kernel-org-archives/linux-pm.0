From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Software Suspend status in latest GIT?
Date: Wed, 6 Aug 2008 18:04:31 +0200
Message-ID: <200808061804.31884.rjw@sisk.pl>
References: <Pine.LNX.4.64.0808051552401.4955@hp9800.localdomain>
	<200808061435.55421.rjw@sisk.pl>
	<Pine.LNX.4.64.0808060852180.6075@hp9800.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0808060852180.6075@hp9800.localdomain>
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
To: Kenneth Crudup <root@panix.com>
Cc: pavel@suse.cz, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 6 of August 2008, Kenneth Crudup wrote:
> 
> On Wed, 6 Aug 2008, Rafael J. Wysocki wrote:
> 
> > Can you try with the patch from
> > http://bugzilla.kernel.org/show_bug.cgi?id=11178#c10
> > please?
> 
> Well- I can suspend now! Make sure that patch goes in for sure!
> 
> ... but the resume fails. It doesn't seem to see the signature in the
> swapspace and begins a regular boot. Let me make sure it's not something
> on my end.
> 
> The kernel command-line (and boot kernel) is exactly the same when
> resuming, right? (Hmmm ... do I explicitly need a "resume=" parameter?)

It's better to always put the resume= parameter into the kernel command line
if you use the /sys/power/state interface.

Thanks,
Rafael
