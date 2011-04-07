From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Thu, 7 Apr 2011 10:34:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104071031590.2147-100000__17392.2048685656$1302187000$gmane$org@iolanthe.rowland.org>
References: <20110407102544.4c34dfeb@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110407102544.4c34dfeb@endymion.delvare>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org, Sonny Rao <sonnyrao@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 7 Apr 2011, Jean Delvare wrote:

> On Thu, 7 Apr 2011 09:00:43 +0100, Mark Brown wrote:
> > On Thu, Apr 07, 2011 at 09:55:13AM +0200, Jean Delvare wrote:
> > > On Thu, 7 Apr 2011 07:31:24 +0900, Mark Brown wrote:
> > 
> > > > You definitely don't know *anything* about the relationships for I2C,
> > > > especially in embedded systems.
> > 
> > > Can you please elaborate? The i2c subsystem uses a standard
> > > parent-children relationship. It seems fairly similar to USB for
> > > example. The only special case I can think of is with bus multiplexing,
> > > but it would be easy enough to switch off async suspend/resume in this
> > > case.
> > 
> > For I2C itself that's the case but for power and GPIO (which are very
> > common in conjunction with I2C in the embedded context) we loose the
> > tree.  This is much less of an issue with buses like PCI where
> > everything is bundled into the bus.
> 
> Out of curiosity, how is this handled in the synchronous suspend/resume
> case?

With synchronous resume, devices are resumed in the order they were
originally registered.  Since the power and GPIO controllers must have
been registered before the I2C controller (otherwise the I2C wouldn't
have been accessible when it was registered!), they will be resumed
first.

Alan Stern
