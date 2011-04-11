From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface
 for interrupt handlers
Date: Mon, 11 Apr 2011 14:37:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104111434390.1975-100000@iolanthe.rowland.org>
References: <4DA3386F.8090609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4DA3386F.8090609@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Apr 2011, Sylwester Nawrocki wrote:

> The regulator driver is a PMIC that uses I2C communication to control
> the voltage regulators. So to be able to control the regulator supplying
> the device, the runtime_resume/suspend callbacks need to be called with 
> interrupts enabled. Otherwise the I2C communication wouldn't work.

Right.  Which obviously means that its callbacks can't be IRQ-safe.

> I don't really need runtime_suspend/resume to be IRQ-safe, just wanted 
> to make sure that in some conditions some other subsystem does not request that.

If it does happen, you can track down the person responsible for 
writing that function call, and complain loudly!  :-)

> As I have seen there is no runtime PM call to clear the power.irq_safe
> flags once it is set, so it looked like pm_runtime_irq_safe() is a basically 
> a "one-time" call.

Yes.  The use cases I could think of were all for platform devices 
where there would never be any reason to clear the flag.

Alan Stern
