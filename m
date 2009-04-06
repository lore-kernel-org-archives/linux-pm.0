From: mark gross <mgross@linux.intel.com>
Subject: Re: Adding PM QoS parameters
Date: Mon, 6 Apr 2009 14:12:37 -0700
Message-ID: <20090406211237.GA25173@linux.intel.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CC66C7DE@dbde02.ent.ti.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC66C7DE@dbde02.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 03, 2009 at 01:55:06AM +0530, Premi, Sanjeev wrote:
> I have just started looking at the PM QoS implementation; I came across this
> text in "pm_qos_interface.txt"
> 
> [quote]
> The infrastructure exposes multiple misc device nodes one per implemented
> parameter.  The set of parameters implement is defined by pm_qos_power_init()
> and pm_qos_params.h.  This is done because having the available parameters
> being runtime configurable or changeable from a driver was seen as too easy to
> abuse.
> [/quote]
> 
> Though I have understood the intent; i feel it may also be limiting the use
> where there is a genuine need - specific to an arch/ platform.
> 
> Can we allow number of these params to grow upto a reasonable limit (say 8)?
> If an arch/platform does not specifies more params, everything remains same.
> But we get an opportunity to add arch/platform specific requirements.

If you do this then user mode software using the interface will not be
portable across architectures.  Is that what you want?


What parameters are you looking to add?  I have gotten very little
feedback on what parameters are missing or wanted.

> 
> Not sure if this has already been discussed earlier, but would like to hear
> more thoughts.

This has not been discussed, but changing the data structures to use
handles instead of strings has brought up once without data showing the
strcmps where a measurable issue.

I'm very open to improvements, applications and further discussions.

--mgross


> 
> Best regards,
> Sanjeev
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
