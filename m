From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 0/6] ACPI: ACPI 5.0 device enumeration
	proposal
Date: Fri, 28 Sep 2012 15:37:43 +0800
Message-ID: <1348817863.10877.320.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi, all,

I'm working on ACPI device enumeration support recently, and here is the
proposal I made to enumerate devices via ACPI namespace.

the main idea is that, for Serial Buses like I2C and SPI, we enumerate
the controller as a platform device, and then enumerate the slaves via
i2c/spi_register_board_info. And then, when the controller is really
probed and enabled in the platform driver, the SPI/I2C bus code will
enumerate I2C/SPI slaves automatically.
And for the other devices, we will enumerate all of them as platform
devices, which is not covered in this patch set yet.

Patch 1 & 2 Introduce ACPI style device match method in platform_match.
this is because an ACPI device may have multiple hardware ID (_HID) and
Compatible IDs, aka, _CID, but in platform device code, only pdev->name
is used to match the driver id_table currently.
Patch 3 introduces a new API acpi_get_generic_resources().
this API is used to convert ACPI style resources to the generic struct
resource.
Patch 4 changes i2c_register_board_info from __init to __devinit.
This is needed because I want to enumerate the slave devices in ACPI I2C
control Driver, which supports hotplug in theory.
Patch 5 introduces the ACPI I2C controller enumeration drive.
it enumerate the ACPI I2C controller to a platform device and then
enumerate the I2C slaves as I2C_board_info.
Patch 6 is an example driver for an ACPI enuemrated I2C controller.

Note that this is just prototype patch set, which just passes build
test. Because I'd like to get your ideas about this before going on.
any comments are welcome.

thanks,
rui
