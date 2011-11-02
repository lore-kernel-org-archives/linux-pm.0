From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION]: hibernate/sleep regression w/ bisection
Date: Wed, 2 Nov 2011 09:31:09 -0700
Message-ID: <20111102163109.GA29430@core.coreip.homeip.net>
References: <20111101124759.GA1326@zeus>
	<20111102054658.GA29035@core.coreip.homeip.net>
	<20111102160208.GA6657@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111102160208.GA6657@zeus>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Watts <akwatts@ymail.com>
Cc: tj@kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 02, 2011 at 11:02:09AM -0500, Andrew Watts wrote:
> On Tue, Nov 01, 2011 at 10:46:58PM -0700, Dmitry Torokhov wrote:
> > 
> > Are you hibernating from text console or X? Can you try plugging in USB
> > keyboard and see if you are getting input? What about ssh into the box?
> 
> Forgot to answer a few of your questions. Plugging in a USB keyboard does
> not help.

OK, it looks like you do have input, what you do not have is X
functioning.

I am not sure why radeon reports lockup with that patch; serio uses
system_long_wq to schedule its long-playing works and the only other
user of system_long_wq seems to be sata, but then concurrency management
should take care of them sharing the workqueue.

Tejun, do you have any ideas here?

Thanks.

-- 
Dmitry
