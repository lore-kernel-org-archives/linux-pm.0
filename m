From: Sonny Rao <sonnyrao@chromium.org>
Subject: [PATCH] Enable async suspend/resume on industrial IO
	devices
Date: Tue,  5 Apr 2011 19:45:14 -0700
Message-ID: <1302057915-13549-1-git-send-email-sonnyrao__9570.7017150291$1302115318$gmane$org@chromium.org>
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
To: jic23@cam.ac.uk
Cc: devel@driverdev.osuosl.org, bleung@chromium.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Phillip Kurtenbach <pkurtenbach@gmail.com>, snanda@chromium.org, linux-pm@lists.linux-foundation.org, Sonny Rao <sonnyrao@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
List-Id: linux-pm@vger.kernel.org

Industrial I/O devices can sometimes take a long time to resume,
allowing them to be asynchronus saves 50ms on one light sensor

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>

---
 drivers/staging/iio/industrialio-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 768f448..a4b099f 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -811,6 +811,8 @@ int iio_device_register(struct iio_dev *dev_info)
 	if (dev_info->modes & INDIO_RING_TRIGGERED)
 		iio_device_register_trigger_consumer(dev_info);
 
+	device_enable_async_suspend(&dev_info->dev);
+
 	return 0;
 
 error_free_sysfs:
-- 
1.7.2.3
