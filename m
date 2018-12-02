From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 06/17] Platform: OLPC: Add XO-1.75 EC driver
Date: Sun, 2 Dec 2018 15:13:28 -0800
Message-ID: <20181202231328.GB23087@wrath>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-7-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-7-lkundrak@v3.sk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 16, 2018 at 05:23:52PM +0100, Lubomir Rintel wrote:
> It's based off the driver from the OLPC kernel sources. Somewhat
> modernized and cleaned up, for better or worse.
> 
> Modified to plug into the olpc-ec driver infrastructure (so that battery
> interface and debugfs could be reused) and the SPI slave framework.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 

Hi Lubomir,

You asked for some tips on how to incorporate the changes in a patch
series like this.

Keep in mind that each patch should create an independent small
functional change. This makes it easier to review the patch and verify
that what you said you were going to do matches what the patch does. For
example, if you separate out the style, whitespace, ordering of
declarations into an initial first patch, then all that noise is removed
when the reviewer goes to check to implementation of one of the features
below.

This is a large patch, and should most certainly be broken up into
several smaller patches. Do cleanups first, followed by functional
changes. This ordering ensure that when a "git blame" is used in the
future to understand why a given line is what it is, the first hit will
be a functional change, and not a cleanup.

> ---
> Changes since v1:
> - Cosmetic style changes; whitespace, ordering of declarations and
>   #includes, remoted extra comas from sentinels

Please make this a separate change, possibly more than one, depending on
how many of these there are. This will reduce the size of the subsequent
patches, making them easier to review.

> - Count the terminating NUL in LOG_BUF_SIZE
> - Make olpc_xo175_ec_is_valid_cmd() return -EINVAL instead of -1
>   on error
> - Spell keyboard/touchpad in full for CHAN_KEYBOARD/TOUCHPAD messages
> - Use a #define for PM wakeup processing time
> - Log a message on unknown event
> - Escape logging payload with %*pE
> - Replace an open-coded min()
> - Correct an error code on short read
> - replaced PM callback #ifdefs with __maybe_unusedm SET_RUNTIME_PM_OPS
>   and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> - dev_get_drvdata() instead of a round-trip through platform device
> - s/unsigned char x/u8 x/ in olpc_xo175_ec_resume()
> - Use GENMASK() instead of 0xffff for the event mask
> - Replace cmd tx/resp rx buffers with structures
> - Turned suspend hint arguments into a struct, and tidied up the comment

Just from these comments, each of these could be a separate patch. You
can group related things together, or those that change the same line or
function for example. Order them with cleanups / non-functional-changes
first, followed by functional changes.

> 
> Basically all of the above is based on the review by Andy Shevchenko.

Andy, what was your intent for Lubomir here? From the above, this looks
like it should be several patches to me.

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
