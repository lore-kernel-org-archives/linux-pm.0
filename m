From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: pm_runtime_suspended() and
	non-pm_runtime-using	(i2c) drivers
Date: Tue, 14 Dec 2010 22:00:51 +0000
Message-ID: <20101214220050.GB25106__8861.40099396489$1292364155$gmane$org@opensource.wolfsonmicro.com>
References: <20101214180941.GB13644@rakim.wolfsonmicro.main>
	<Pine.LNX.4.44L0.1012141406500.2087-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1012141406500.2087-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 14, 2010 at 02:10:58PM -0500, Alan Stern wrote:

> I see.  It sounds like you're really saying that new devices default to 
> the wrong runtime state.  If pm_runtime_init() would set new devices to 
> RPM_ACTIVE instead of RPM_SUSPENDED then this problem wouldn't arise.  
> Children could do whatever they want, and even if the parent's driver 
> was totally ignorant of runtime PM, it would work out.

In this case that's the desired behaviour but I worry that it'd break
some other use case (eg, keeping a parent awake because there was an
unclaimed device sitting around).  

When I've been working with the runtime PM subsystem before I've thought
that it might be nice to have a specific RPM_UNINITIAZLIZED state which
would generally get out of the way.  It might be a bit clearer than the
current situation conceptually but I've never felt I had a firm enough
grasp on what was going on to really say, everything always feels more
complicated than I feel it should if I understood it properly.

Thinking about it in the case of I2C we probably also want to mark the
device as ignoring its children when it registers as an I2C controller,
while an I2C controller that does runtime PM will probably figure this
out for itself it would save a bit of effort.
