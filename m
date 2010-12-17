From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Fri, 17 Dec 2010 12:54:28 +0000
Message-ID: <20101217125427.GA29640__13890.5631065883$1292590594$gmane$org@sirena.org.uk>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rabin Vincent <rabin@rab.in>
Cc: linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 16, 2010 at 11:56:57PM +0530, Rabin Vincent wrote:

> There seem to be some differences between the generic ops and the i2c
> and platform busses' implementations of the interaction between runtime
> PM and system sleep:

>   (1) The platform bus does not implement the
>       don't-call-pm->suspend()-if pm_runtime_suspended()-returns-true
>       functionality implemented by the generic ops and i2c.

This is platform lagging behind I2C in implementation - both originally 
did what platform does and then I2C was updated and platform wasn't.

It'd be really good if this could all be factored out into the PM core,
we're going to have to do the same thing for at least SPI as well and
possibly some other buses :/
