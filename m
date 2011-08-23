From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/2] Add runtime PM support to Primecell bus
Date: Tue, 23 Aug 2011 11:15:55 +0100
Message-ID: <20110823101555.GE19622__42182.7506776482$1314094650$gmane$org@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

These patches add basic runtime PM support to the Primecell bus type, so
that the bus clock can be managed according to the activities of devices
attached to it.

The inspiration of the bus level implementation was taken from PCI,
originally written by Rafael.

Adding the bus level runtime PM support requires removing the runtime PM
setup/teardown from the SPI driver, hence why the SPI driver features in
patch 1.

Patch 2 adds runtime PM support to the MMC interface driver.

Please can I have acks for these two patches.  It's likely that they will
depend on other ARM work.

Thanks.
