From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 20:11:42 +0100
Message-ID: <20100513191142.GA18886__45045.0839860879$1273778028$gmane$org@srcf.ucam.org>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<20100513121745.GA10749@srcf.ucam.org>
	<1273771990.19100.13.camel@c-dwalke-linux.qualcomm.com>
	<s2ga55d774e1005131117yd138c59bk54cc109401eb4a8d@mail.gmail.com>
	<1273775157.19100.20.camel@c-dwalke-linux.qualcomm.com>
	<20100513183646.GA18155@srcf.ucam.org>
	<1273777177.19100.24.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1273777177.19100.24.camel@c-dwalke-linux.qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@ericsson.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 13, 2010 at 11:59:37AM -0700, Daniel Walker wrote:
> On Thu, 2010-05-13 at 19:36 +0100, Matthew Garrett wrote:
> > Deprecating sysfs interfaces can be done within 6 months or so, 
> > especially if there's only one real consumer.
> 
> I'll assume your right (can you give an example of this?), but why
> should we even add it if we know it's already going to get replaced.
> It's like it's pre-deprecated ..

See feature-removal-schedule.txt. So far we have no indication that it's 
going to be replaced, because nobody has actually suggested a working 
way to do this better. If we had a concrete implementation proposal for 
that then we'd be in a pretty different position right now.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
