From: Greg KH <greg@kroah.com>
Subject: Re: [RFC PATCH] thermal: Add support to report cooling
 statistics achieved by cooling devices
Date: Mon, 6 Feb 2012 09:03:49 -0800
Message-ID: <20120206170348.GA19749@kroah.com>
References: <1326878467-17766-1-git-send-email-amit.kachhap@linaro.org>
	<20120206165658.GA28687@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120206165658.GA28687@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, rob.lee@linaro.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 06, 2012 at 05:56:58PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Add a sysfs node code to report effective cooling of all cooling devices
> > attached to each trip points of a thermal zone. The cooling data reported
> > will be absolute if the higher temperature trip points are arranged first
> > otherwise the cooling stats is the cumulative effect of the earlier
> > invoked cooling handlers.
> > 
> > The basic assumption is that cooling devices will bring down the temperature
> > in a symmetric manner and those statistics can be stored back and used for
> > further tuning of the system.
> 
> /sys fs should be one-value-per-file, talk to gregkh.

That's correct.

Why not use debugfs for this instead?

thanks,

greg k-h
