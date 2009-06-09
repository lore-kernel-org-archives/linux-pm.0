From: Zhang Rui <rui.zhang@intel.com>
Subject: does anyone have Dell Latitude E6400?
Date: Tue, 09 Jun 2009 14:44:21 +0800
Message-ID: <1244529861.9076.61.camel__41351.9013244242$1244529916$gmane$org@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi, all,

I need to purchase a laptop with ambient light sensor to implement the
ACPI ambient light sensor driver in Linux.
Google tells me that Dell Latitude e6400 has this, but I'm not sure if
the sensor is controlled via ACPI or platform specific methods.
so can anybody that has this laptop send me the lspci and acpidump
output please?

If somebody knows some other laptop models with this ACPI device (grep
ACPI0008 and _ALI/_ALR control methods in the acpidump), please let me
know.

BTW, to get the acpidump output, you need to download the latest pmtools
at http://www.lesswatts.org/projects/acpi/utilities.php,
build and run "acpidump > acpidump.log".

thanks,
rui
