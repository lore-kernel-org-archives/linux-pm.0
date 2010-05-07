From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 19:28:24 +0100
Message-ID: <20100507182824.GA25198__1273.21652039445$1273257071$gmane$org@srcf.ucam.org>
References: <20100506172201.GA28578@srcf.ucam.org>
	<20100506173807.GD30928@atomide.com>
	<20100506174331.GA29103@srcf.ucam.org>
	<20100506183335.GE30928@atomide.com>
	<20100506184418.GA30669@srcf.ucam.org>
	<20100507020541.GH30928@atomide.com>
	<20100507171218.GA23142@srcf.ucam.org>
	<20100507173549.GF387@atomide.com>
	<20100507175025.GA23952@srcf.ucam.org>
	<20100507180152.GH387@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100507180152.GH387@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 07, 2010 at 11:01:52AM -0700, Tony Lindgren wrote:
> * Matthew Garrett <mjg@redhat.com> [100507 10:46]:
> > Effective power management in the face of real-world applications is a 
> > reasonable usecase.
> 
> Sure there's no easy solution to misbehaving apps.

That's the point of the suspend blockers.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
