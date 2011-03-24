From: Len Brown <lenb@kernel.org>
Subject: Re: [stable] [PATCH 1/2 2.6.37.stable] intel_idle:
 disable NHM/WSM HW C-state auto-demotion
Date: Wed, 23 Mar 2011 22:53:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103232252000.12911@x980>
References: <alpine.LFD.2.02.1103222222490.10489@x980>
	<20110323225420.GE27334@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110323225420.GE27334@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 23 Mar 2011, Greg KH wrote:

> On Tue, Mar 22, 2011 at 10:24:43PM -0400, Len Brown wrote:
> > From: Len Brown <len.brown@intel.com>
> > 
> > upstream 14796fca2bd22acc73dd0887248d003b0f441d08
> > 
> > Hardware C-state auto-demotion is a mechanism where the HW overrides
> > the OS C-state request, instead demoting to a shallower state,
> > which is less expensive, but saves less power.
> > 
> > Modern Linux should generally get exactly the states it requests.
> > In particular, when a CPU is taken off-line, it must not be demoted, else
> > it can prevent the entire package from reaching deep C-states.
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=25252
> > 
> > Signed-off-by: Len Brown <len.brown@intel.com>
> 
> This patch doesn't apply to the .38-stable tree, and it also needs to go
> there, right?  Can you please send a version that I can apply?

it is already present in 2.6.38, as is the next one.
That is why the subject specified 2.6.37.stable.

thanks,
-Len
