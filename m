From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Thu, 7 Apr 2011 10:25:44 +0200
Message-ID: <20110407102544.4c34dfeb__30802.9452026405$1302164799$gmane$org@endymion.delvare>
References: <20110406095240.410b4e7e@endymion.delvare>
	<Pine.LNX.4.44L0.1104061043220.1907-100000@iolanthe.rowland.org>
	<20110406223123.GA5297@opensource.wolfsonmicro.com>
	<20110407095513.4c0b708e@endymion.delvare>
	<20110407080042.GF14519@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110407080042.GF14519@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org, Sonny Rao <sonnyrao@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 7 Apr 2011 09:00:43 +0100, Mark Brown wrote:
> On Thu, Apr 07, 2011 at 09:55:13AM +0200, Jean Delvare wrote:
> > On Thu, 7 Apr 2011 07:31:24 +0900, Mark Brown wrote:
> 
> > > You definitely don't know *anything* about the relationships for I2C,
> > > especially in embedded systems.
> 
> > Can you please elaborate? The i2c subsystem uses a standard
> > parent-children relationship. It seems fairly similar to USB for
> > example. The only special case I can think of is with bus multiplexing,
> > but it would be easy enough to switch off async suspend/resume in this
> > case.
> 
> For I2C itself that's the case but for power and GPIO (which are very
> common in conjunction with I2C in the embedded context) we loose the
> tree.  This is much less of an issue with buses like PCI where
> everything is bundled into the bus.

Out of curiosity, how is this handled in the synchronous suspend/resume
case?

-- 
Jean Delvare
