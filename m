From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [driver-core PATCH v4 3/6] device core: Consolidate locking and
 unlocking of parent and device
Date: Thu, 18 Oct 2018 10:53:35 -0700
Message-ID: <1539885215.81977.8.camel@acm.org>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
         <20181015150920.29520.32815.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015150920.29520.32815.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, tj@kernel.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-10-15 at 08:09 -0700, Alexander Duyck wrote:
+AD4 This patch is meant to try and consolidate all of the locking and unlocking
+AD4 of both the parent and device when attaching or removing a driver from a
+AD4 given device.
+AD4 
+AD4 To do that I first consolidated the lock pattern into two functions
+AD4 +AF8AXw-device+AF8-driver+AF8-lock and +AF8AXw-device+AF8-driver+AF8-unlock. After doing that I then
+AD4 created functions specific to attaching and detaching the driver while
+AD4 acquiring this locks. By doing this I was able to reduce the number of
            +AF4AXgBeAF4
Should +ACI-this+ACI perhaps be changed into +ACI-these+ACI?
 
+AD4 +-/+ACo
+AD4 +- +ACo +AF8AXw-device+AF8-driver+AF8-lock - acquire locks needed to manipulate dev-+AD4-drv
+AD4 +- +ACo +AEA-dev: Device we will update driver info for
+AD4 +- +ACo +AEA-parent: Parent device needed if the bus requires parent lock

Please consider splitting that description into two sentences to enhance
clarity, e.g. +ACI-Parent device. Needed if the bus requires parent lock.+ACI

+AD4 +- +ACo +AEA-parent: Parent device needed if the bus requires parent lock

Same comment here.

+AD4  /+ACoAKg
+AD4 +- +ACo device+AF8-driver+AF8-detach - detach driver from a specific device
+AD4 +- +ACo +AEA-dev: device to detach driver from
+AD4 +- +ACo
+AD4 +- +ACo Manually detach driver from device. Will acquire both +AEA-dev lock and
+AD4 +- +ACo +AEA-dev-+AD4-parent lock if needed.
+AD4 +- +ACo-/
+AD4 +-void device+AF8-driver+AF8-detach(struct device +ACo-dev)
+AD4 +-+AHs
+AD4 +-	device+AF8-release+AF8-driver+AF8-internal(dev, NULL, dev-+AD4-parent)+ADs
+AD4 +-+AH0
+AD4 +-
+AD4 +-/+ACoAKg
+AD4   +ACo driver+AF8-detach - detach driver from all devices it controls.
+AD4   +ACo +AEA-drv: driver.
+AD4   +ACo-/

Elsewhere in the driver core the word +ACI-manually+ACI only appears in comments
above exported functions and functions that implement sysfs store methods.
Since device+AF8-driver+AF8-detach() is neither, I think the word +ACI-manually+ACI should
not be used in the comment block above that function. But since the rest of
this patch looks fine to me, feel free to add:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4-
